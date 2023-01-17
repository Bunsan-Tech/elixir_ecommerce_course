defmodule EcommerceCourse.Repo.Migrations.AddressBelongsToUser do
  use Ecto.Migration

  def up do
    alter table(:addresses) do
      add :user_id, references(:users, type: :uuid), null: false
    end
  end

  def down do
    alter table(:addresses) do
      remove(:user_id)
    end
  end
end
