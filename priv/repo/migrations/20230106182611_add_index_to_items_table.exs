defmodule EcommerceCourse.Repo.Migrations.AddIndexToItemsTable do
  use Ecto.Migration

  def up do
    create index(:items, [:name])
    create index(:items, [:name, :sku])
  end

  def down do
    drop index(:items, [:name])
    drop index(:items, [:name, :sku])
  end
end
