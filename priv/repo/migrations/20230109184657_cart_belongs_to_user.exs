defmodule EcommerceCourse.Repo.Migrations.CartBelongsToUser do
  use Ecto.Migration

  def up do
    alter table(:carts) do
      add :user_id, references(:users, type: :uuid), null: false
    end
  end

  def down do
    alter table(:carts) do
      remove(:user_id)
    end
  end
end
