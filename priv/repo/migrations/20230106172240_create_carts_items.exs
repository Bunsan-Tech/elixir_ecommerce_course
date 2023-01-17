defmodule EcommerceCourse.Repo.Migrations.CreateCartsItems do
  use Ecto.Migration

  def up do
    create table(:cart_items, primary_key: false) do
      add :id, :uuid, primary_key: true, null: false
      add :quantity, :integer, null: false
      add :price, :float
      add :cart_id, references(:carts, type: :uuid), null: false
      add :item_id, references(:items, type: :uuid), null: false
    end

    create unique_index(:cart_items, [:cart_id, :item_id])
  end

  def down do
    drop index(:cart_items, [:cart_id, :item_id])
    drop table(:cart_items)
  end
end
