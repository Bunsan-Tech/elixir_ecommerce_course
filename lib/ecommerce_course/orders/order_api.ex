defmodule EcommerceCourse.Orders.OrderAPI do
  alias Ecto.UUID
  alias Ecto.Changeset
  alias EcommerceCourse.Orders.{ContactInfo, Order}

  @typep payment_info :: %{
           required(:payment_method) => String.t(),
           required(:card_number) => String.t()
         }
  @typep order_params :: %{
           required(:location) => String.t(),
           required(:contact_info_id) => UUID.t(),
           required(:user_id) => UUID.t(),
           required(:cart_id) => UUID.t(),
           optional(:delivery_date) => String.t(),
           optional(:status) => String.t(),
           optional(:price) => number()
         }

  # Order callbacks
  @callback list_orders() :: list(Order.t())
  @callback get_order!(id :: UUID.t()) :: Order.t()
  @callback create_order(attrs :: order_params(), payment_info_params :: payment_info()) ::
              {:ok, Order.t()} | {:error, Changeset.t()}
  @callback update_order(order :: Order.t(), attrs :: order_params()) ::
              {:ok, Order.t()} | {:error, Changeset.t()}
  @callback delete_order(order :: Order.t()) :: {:ok, Order.t()} | {:error, Changeset.t()}
  @callback change_order(attrs :: order_params()) :: Changeset.t()

  @typep contact_params :: %{
           required(:contact_info) => String.t(),
           required(:phone) => String.t(),
           required(:address) => address_params()
         }
  @type address_params :: %{
          required(:country_code) => String.t(),
          required(:postal_code) => String.t(),
          required(:street) => String.t(),
          required(:neighborhood) => String.t(),
          optional(:reference) => String.t()
        }

  # Contact info callbacks
  @callback get_contact_info!(id :: UUID.t()) :: ContactInfo.t()
  @callback create_contact_info(attrs :: contact_params()) ::
              {:ok, ContactInfo.t()} | {:error, Changeset.t()}
  @callback update_contact_info(contact_info :: ContactInfo.t(), attrs :: map()) ::
              {:ok, ContactInfo.t()} | {:error, Changeset.t()}
  @callback delete_contact_info(contact_info :: ContactInfo.t()) ::
              {:ok, ContactInfo.t()} | {:error, Changeset.t()}
  @callback change_contact_info(attrs :: contact_params()) :: Changeset.t()
end
