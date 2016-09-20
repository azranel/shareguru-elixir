defmodule Shareguru.LinkControllerTest do
  use Shareguru.ConnCase

  alias Shareguru.Link
  alias Shareguru.User
  @valid_attrs %{description: "some content", url: "some content"}
  @invalid_attrs %{}
  
  setup do
    %User{
      id: 123456,
      name: "dude",
      email: "dude@example.com"
    } |> Repo.insert
    
    {:ok, user: Repo.get(User, 123456) }
  end

  test "lists all entries on index", %{conn: conn, user: user} do
    conn = conn
    |> assign(:current_user, user)
    |> get(link_path(conn, :index))
    assert html_response(conn, 200) =~ "Listing links"
  end

  test "renders form for new resources", %{conn: conn, user: user} do
    conn = conn
    |> assign(:current_user, user)
    |> get(link_path(conn, :new))
    assert html_response(conn, 200) =~ "New link"
  end

  test "creates resource and redirects when data is valid", %{conn: conn, user: user} do
    conn = conn
    |> assign(:current_user, user)
    |> post(link_path(conn, :create), link: @valid_attrs)
    assert redirected_to(conn) == link_path(conn, :index)
    assert Repo.get_by(Link, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn, user: user} do
    conn = conn
    |> assign(:current_user, user)
    |> post(link_path(conn, :create), link: @invalid_attrs)
    assert html_response(conn, 200) =~ "New link"
  end

  test "shows chosen resource", %{conn: conn, user: user} do
    link = Repo.insert! %Link{}
    conn = conn
    |> assign(:current_user, user)
    |> get(link_path(conn, :show, link))
    assert html_response(conn, 200) =~ "Show link"
  end

  test "renders page not found when id is nonexistent", %{conn: conn, user: user} do
    assert_error_sent 404, fn ->
      conn
      |> assign(:current_user, user)
      |> get(link_path(conn, :show, -1))
    end
  end

  test "renders form for editing chosen resource", %{conn: conn, user: user} do
    link = Repo.insert! %Link{}
    conn = conn
    |> assign(:current_user, user)
    |> get(link_path(conn, :edit, link))
    assert html_response(conn, 200) =~ "Edit link"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn, user: user} do
    link = Repo.insert! %Link{user_id: 123456}
    conn = conn
    |> assign(:current_user, user)
    |> put(link_path(conn, :update, link), link: @valid_attrs)
    assert redirected_to(conn) == link_path(conn, :show, link)
    assert Repo.get_by(Link, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn, user: user} do
    link = Repo.insert! %Link{}
    conn = conn
    |> assign(:current_user, user)
    |> put(link_path(conn, :update, link), link: @invalid_attrs)
    assert html_response(conn, 200) =~ "Edit link"
  end

  test "deletes chosen resource", %{conn: conn, user: user} do
    link = Repo.insert! %Link{}
    conn = conn
    |> assign(:current_user, user)
    |> delete(link_path(conn, :delete, link))
    assert redirected_to(conn) == link_path(conn, :index)
    refute Repo.get(Link, link.id)
  end
end
