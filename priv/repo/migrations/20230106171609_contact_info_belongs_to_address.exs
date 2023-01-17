defmodule EcommerceCourse.Repo.Migrations.ContactInfoBelongsToAddress do
  use Ecto.Migration

  def up do
    alter table(:contact_info) do
      add :address_id, references(:addresses, type: :uuid), null: false
    end
  end

  def down do
    alter table(:contact_info) do
      remove(:address_id)
    end
  end
end
