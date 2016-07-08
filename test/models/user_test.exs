defmodule Shareguru.UserTest do
  use Shareguru.ModelCase

  alias Shareguru.User

  @valid_attrs %{email: "cool_email@email.com", expire_at: "2010-04-17 14:00:00", name: "Bartosz Łęcki", picture: "http://google.pl/some_cool_picture.png"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end
end