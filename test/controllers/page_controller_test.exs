defmodule Shareguru.PageControllerTest do
  use Shareguru.ConnCase

  test "GET / when not logged in", %{conn: conn} do
    conn = get conn, "/"
    assert Shareguru.UserSession.current_user(conn) == nil
    assert redirected_to(conn) =~ "/auth/google"
  end

  test "GET / when logged in", %{conn: conn} do
    user = %Shareguru.User{
      id: 123,
      name: "dude",
      email: "dude@example.com"
    }

    conn = conn 
    |> with_current_user(user) 
    |> get("/")
    assert conn.status == 200
  end
end
