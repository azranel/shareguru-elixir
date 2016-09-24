defmodule Shareguru.AuthController do
  @moduledoc """
  Auth controller responsible for handling Ueberauth responses
  """

  use Shareguru.Web, :controller
  plug Ueberauth

  alias Ueberauth.Strategy.Helpers
  alias Shareguru.User
  alias Shareguru.Repo

  def request(conn, _params) do
    render(conn, "request.html", callback_url: Helpers.callback_url(conn))
  end

  def delete(conn, _params) do
    conn
    |> put_flash(:info, "You have been logged out!")
    |> Shareguru.UserSession.logout
    |> redirect(to: "/")
  end

  def callback(%{assigns: %{ueberauth_failure: _fails}} = conn, _params) do
    conn
    |> put_flash(:error, "Failed to authenticate.")
    |> redirect(to: "/")
  end

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    changeset = User.changeset(%User{}, auth.extra.raw_info.user)
    case Repo.insert(changeset) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "Successfully authenticated.")
        |> Shareguru.UserSession.login_user(user)
        |> redirect(to: Shareguru.Router.Helpers.page_path(conn, :index))
      {:error, reason} ->
        conn
        |> put_flash(:error, reason)
        |> redirect(to: "/")
    end
  end
end
