defmodule Shareguru.PageControllerTest do
  use Shareguru.ConnCase

  alias Plug.Conn

  @default_opts [
    store: :cookie,
    key: "foobar",
    encryption_salt: "encrypted cookie salt",
    signing_salt: "signing salt",
    log: false
  ]
  @signing_opts Plug.Session.init(Keyword.put(@default_opts, :encrypt, false))
  @secret_key String.duplicate("abcdef0123456789", 8)

  test "GET / when not logged in", %{conn: conn} do
    conn = get conn, "/"
    assert redirected_to(conn) =~ "/auth/google"
  end

  test "GET / when logged in", %{conn: conn} do
    conn = put_in(conn.secret_key_base, @secret_key)
      |> Plug.Session.call(@signing_opts)
      |> fetch_session
      |> Conn.put_session(:current_user, "Sample user")
      |> get("/")
    assert redirected_to(conn) =~ "/auth/google"
  end
end
