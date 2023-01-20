defmodule EcommerceCourse.Factory do
  use ExMachina.Ecto, repo: EcommerceCourse.Repo
  use EcommerceCourse.UserFactory
  use EcommerceCourse.OrderFactory
  use EcommerceCourse.ContactInfoFactory
  use EcommerceCourse.ItemFactory
  use EcommerceCourse.CartFactory
end
