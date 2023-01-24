defmodule EcommerceCourse.Orders.OrderAPI do
  alias Ecto.UUID
  alias Ecto.Changeset
  alias EcommerceCourse.Orders.{ContactInfo, Order}

  # Order callbacks
  @callback list_orders() :: list(Order.t())
  @callback get_order!(id :: UUID.t()) :: Order.t()
  @callback create_order(attrs :: map(), payment_info_params :: map()) ::
              {:ok, Order.t()} | {:error, Changeset.t()}
  @callback update_order(order :: Order.t(), attrs :: map()) ::
              {:ok, Order.t()} | {:error, Changeset.t()}
  @callback delete_order(order :: Order.t()) :: {:ok, Order.t()} | {:error, Changeset.t()}
  @callback change_order(attrs :: map()) :: Changeset.t()

  # Contact info callbacks
  @callback get_contact_info!(id :: UUID.t()) :: ContactInfo.t()
  @callback create_contact_info(attrs :: map()) ::
              {:ok, ContactInfo.t()} | {:error, Changeset.t()}
  @callback update_contact_info(contact_info :: ContactInfo.t(), attrs :: map()) ::
              {:ok, ContactInfo.t()} | {:error, Changeset.t()}
  @callback delete_contact_info(contact_info :: ContactInfo.t()) ::
              {:ok, ContactInfo.t()} | {:error, Changeset.t()}
  @callback change_contact_info(attrs :: map()) :: Changeset.t()
end
