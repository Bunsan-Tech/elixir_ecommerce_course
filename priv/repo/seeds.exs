# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     EcommerceCourse.Repo.insert!(%EcommerceCourse.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
#
# Users
users_list = [
  %{username: "xochitl", email: "xochitl@bunsan.io", password: "12345678"},
  %{username: "luis", email: "luis@bunsan.io", password: "12356645678"},
  %{username: "jose_luis", email: "jose_luis@bunsan.io", password: "4443434343"},
  %{username: "misael", email: "misael@bunsan.io", password: "098999000"},
  %{username: "norberto", email: "norberto@bunsan.io", password: "34566655334"}
]

Enum.each(users_list, &EcommerceCourse.Users.create_user/1)

# Items

products_list = [
  %{
    name: "Lego bb8",
    description: "this a toy for + 13 years",
    price: 800.00,
    quantity: 9,
    sku: "4895028513405",
    image: "https://http2.mlstatic.com/D_NQ_NP_912435-MLM48593124691_122021-F.jpg"
  },
  %{
    name: "LEGO Kit de construcci√≥n 10280 Ramo de Flores",
    description: "this a toy for + 13 years",
    price: 1477.00,
    quantity: 1,
    sku: "4895128513405",
    image: "https://m.media-amazon.com/images/I/81NCFZ3iJdL._AC_SX522_.jpg"
  },
  %{
    name: "USAopoly Rompecabezas de Piedra de Harry Potter y el hechicero",
    description: "this a toy for +0 years",
    price: 350.00,
    quantity: 100,
    sku: "4895028813405",
    image: "https://m.media-amazon.com/images/I/71pkb0y3cmL._AC_SX522_.jpg"
  },
  %{
    name: "LEGO, Juego de Construcci√≥n, Grande",
    description: "this a toy for +5 years",
    price: 999.00,
    quantity: 9,
    sku: "4895028513407",
    image: "https://m.media-amazon.com/images/I/91SXHJRqWqL._AC_SX522_.jpg"
  },
  %{
    name: "Mega Construx Juguete de Construcci√≥n Pok√©mon Pack De Pokebolas",
    description: "this a toy for + 13 years",
    price: 780.00,
    quantity: 9,
    sku: "4895028613405",
    image: "https://m.media-amazon.com/images/I/817EhuW-PsL._AC_SX679_.jpg"
  }
]

Enum.each(products_list, &EcommerceCourse.Items.create_item/1)
