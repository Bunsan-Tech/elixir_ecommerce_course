defmodule EcommerceCourse.Repo.Migrations.CreateContactInfo do
  use Ecto.Migration

  def up do
    create table(:contact_info, primary_key: false) do
      add :id, :uuid, primary_key: true, null: false
      add :email, :string
      add :phone, :string

      timestamps()
    end
  end

  def down do
    drop table(:contact_info)
  end
end
