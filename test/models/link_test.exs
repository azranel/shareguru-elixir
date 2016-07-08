defmodule Shareguru.LinkTest do
  use Shareguru.ModelCase

  alias Shareguru.Link

  @valid_attrs %{
    description: "some content",
    url: "some content"
  }
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Link.changeset(%Link{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Link.changeset(%Link{}, @invalid_attrs)
    refute changeset.valid?
  end
end
