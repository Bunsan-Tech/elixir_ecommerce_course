defmodule EcommerceCourse.Factory do
  use Boundary, top_level?: true, check: [out: false]

  use ExMachina.Ecto, repo: EcommerceCourse.Repo
  use EcommerceCourse.Factory.UserFactory
  use EcommerceCourse.Factory.OrderFactory
  use EcommerceCourse.Factory.ContactInfoFactory
  use EcommerceCourse.Factory.ItemFactory
  use EcommerceCourse.Factory.CartFactory
end
