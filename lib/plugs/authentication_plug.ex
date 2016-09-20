defmodule Shareguru.AuthenticationPlug do
  import Plug.Conn
  import Plug.Session
  alias Shareguru.Router.Helpers
  alias Shareguru.Endpoint

  def init(options), do: options

  def call(%{assigns: %{current_user: user}} = conn, _) when user != nil do
    conn
  end

  def call(conn, _) do
    do_redirect(conn, Helpers.auth_path(Endpoint, :request, "google"))
  end

  defp do_redirect(conn, to) do
    conn
      |> Phoenix.Controller.redirect(to: to)
      |> halt
  end
end
