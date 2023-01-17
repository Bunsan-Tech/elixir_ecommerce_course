defmodule EcommerceCourse.Repo.Migrations.CreateOrders do
  use Ecto.Migration

  def up do
    create table(:orders, primary_key: false) do
      add :id, :uuid, primary_key: true, null: false
      add :price, :float
      add :status, :string
      add :location, :string
      add :delivery_date, :utc_datetime_usec

      timestamps()
    end
  end

  def down do
    drop table(:orders)
  end
end
