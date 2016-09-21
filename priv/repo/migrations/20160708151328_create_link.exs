defmodule Shareguru.Repo.Migrations.CreateLink do
  use Ecto.Migration

  def change do
    create table(:links) do
      add :description, :string
      add :url, :string

      timestamps
    end

    create unique_index(:links, [:url])
  end
end
