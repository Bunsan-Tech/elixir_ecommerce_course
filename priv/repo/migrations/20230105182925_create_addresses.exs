defmodule EcommerceCourse.Repo.Migrations.CreateAddresses do
  use Ecto.Migration

  def up do
    create table(:addresses, primary_key: false) do
      add :id, :uuid, primary_key: true, null: false
      add :country_code, :string
      add :postal_code, :string
      add :street, :string
      add :neighborhood, :string
      add :reference, :string

      timestamps()
    end
  end

  def down do
    drop table(:addresses)
  end
end
