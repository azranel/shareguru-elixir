defmodule Shareguru.ConnCase do
  @moduledoc """
  This module defines the test case to be used by
  tests that require setting up a connection.

  Such tests rely on `Phoenix.ConnTest` and also
  imports other functionality to make it easier
  to build and query models.

  Finally, if the test case interacts with the database,
  it cannot be async. For this reason, every test runs
  inside a transaction which is reset at the beginning
  of the test unless the test case is marked as async.
  """

  use ExUnit.CaseTemplate

  using do
    quote do
      # Import conveniences for testing with connections
      use Phoenix.ConnTest

      alias Shareguru.Repo
      import Ecto
      import Ecto.Changeset
      import Ecto.Query, only: [from: 1, from: 2]

      import Shareguru.Router.Helpers

      # The default endpoint for testing
      @endpoint Shareguru.Endpoint
    end
  end

  setup tags do
    unless tags[:async] do
      Ecto.Adapters.SQL.restart_test_transaction(Shareguru.Repo, [])
    end
    
    conn = Phoenix.ConnTest.conn()

    conn = cond do
      tags[:authorised] -> authorised(conn)          
      true -> conn
    end

    {:ok, conn: conn}
  end
  
  defp authorised(conn) do
    import Plug.Conn, only: [assign: 3]
    alias Shareguru.Repo
    alias Shareguru.User
    
    %User{
      id: 123,
      name: "dude",
      email: "dude@example.com"
    } |> Repo.insert

    conn |> assign(:current_user, Repo.get(User, 123))
  end
end
