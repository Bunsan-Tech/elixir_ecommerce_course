defmodule EcommerceCourse.Factory.ContactInfoFactory do
  alias EcommerceCourse.Addresses.Address
  alias EcommerceCourse.Orders.ContactInfo

  defmacro __using__(_opts) do
    quote do
      def contact_info_factory do
        %ContactInfo{
          email: Faker.Internet.email(),
          phone: Faker.Phone.EnUs.phone(),
          address: build(:address)
        }
      end

      def address_factory do
        %Address{
          country_code: Faker.Address.country_code(),
          neighborhood: Faker.Address.street_name(),
          postal_code: Faker.Address.postcode(),
          reference: Faker.Address.street_name(),
          street: Faker.Address.street_name(),
          user: build(:user)
        }
      end
    end
  end
end
