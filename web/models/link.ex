defmodule Shareguru.Link do
  use Shareguru.Web, :model

  schema "links" do
    field :description, :string
    field :url, :string

    belongs_to :user, Shareguru.User

    timestamps
  end

  @required_fields ~w(description url user_id)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> unique_constraint(:url)
  end
end
