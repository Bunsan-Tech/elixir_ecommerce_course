defmodule EcommerceCourse.Repo.Migrations.AddUniqueIndexToItemsTable do
  use Ecto.Migration

  def up do
    create unique_index(:items, :sku)
  end

  def down do
    drop index(:items, [:sku])
  end
end
