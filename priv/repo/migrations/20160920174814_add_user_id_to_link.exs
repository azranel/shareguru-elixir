defmodule Shareguru.Repo.Migrations.AddUserIdToLink do
  use Ecto.Migration

  def change do
    alter table(:links) do
      add :user_id, :integer
    end
  end
end
