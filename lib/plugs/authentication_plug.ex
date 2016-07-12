defmodule Shareguru.AuthenticationPlug do
  import Plug.Conn
  import Plug.Session

  def init(options), do: options

  def call(conn, _) do
    case get_session(conn, :current_user) do
      nil -> do_redirect(conn, Shareguru.Router.Helpers.auth_path(Shareguru.Endpoint, :request, "google"))
      _ -> conn
    end
  end

  defp do_redirect(conn, to) do
    conn
      |> Phoenix.Controller.redirect(to: to)
      |> halt
  end
end
