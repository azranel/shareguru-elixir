defmodule Shareguru.AuthenticationPlug do
  import Plug.Conn
  import Plug.Session
  alias Shareguru.Router.Helpers
  alias Shareguru.Endpoint
  alias Shareguru.UserSession

  def init(options), do: options

  def call(conn, _) do
    if UserSession.current_user(conn) do
      conn |> Plug.Conn.assign(:current_user, UserSession.current_user(conn))
    else
      do_redirect(conn, Helpers.auth_path(Endpoint, :request, "google"))
    end
  end

  defp do_redirect(conn, to) do
    conn
      |> Phoenix.Controller.redirect(to: to)
      |> halt
  end
end
