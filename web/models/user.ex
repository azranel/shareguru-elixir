defmodule Shareguru.User do
  use Shareguru.Web, :model

  schema "users" do
    field :name, :string
    field :email, :string
    field :picture, :string
    field :expire_at, Ecto.DateTime

    has_many :links, Shareguru.Link

    timestamps
  end

  @required_fields ~w(name email picture)
  @optional_fields ~w(expire_at)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> validate_format(:email, ~r/@/)
  end
end
