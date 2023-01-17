defmodule EcommerceCourse.Repo.Migrations.OrderBelongsToCart do
  use Ecto.Migration

  def up do
    alter table(:orders) do
      add :cart_id, references(:carts, type: :uuid), null: false
    end
  end

  def down do
    alter table(:orders) do
      remove(:cart_id)
    end
  end
end
