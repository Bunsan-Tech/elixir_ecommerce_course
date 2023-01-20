alias EcommerceCourse.Checkout
alias EcommerceCourse.Items.BulkUpload
Mimic.copy(BulkUpload)
Mimic.copy(Checkout)

Faker.start()
ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(EcommerceCourse.Repo, :manual)
{:ok, _} = Application.ensure_all_started(:ex_machina)
