defmodule EcommerceCourse.Repo.Migrations.AddIndexToOrdersTable do
  use Ecto.Migration

  def up do
    create index(:orders, [:updated_at, :status])
    create index(:orders, [:price])
    create index(:orders, [:delivery_date])
  end

  def down do
    drop index(:orders, [:updated_at, :status])
    drop index(:orders, [:price])
    drop index(:orders, [:delivery_date])
  end
end
