defmodule EcommerceCourseWeb.Router do
  use EcommerceCourseWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {EcommerceCourseWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :maybe_browser_auth do
    plug EcommerceCourse.AuthAccessPipeline
  end

  scope "/", EcommerceCourseWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/api/v1", EcommerceCourseWeb do
    pipe_through([:api])

    post("/login", AuthController, :login)
    post("/logout", AuthController, :logout)
  end

  scope "/api/v1", EcommerceCourseWeb do
    pipe_through([:api, :maybe_browser_auth])

    resources("/items", ItemController, except: [:new, :edit])
    get "/items_by_stream", ItemController, :show_by_stream
    resources("/users", UserController, except: [:new, :edit])
    resources("/orders", OrderController, except: [:new, :edit])
    resources "/contact_info", ContactInfoController, except: [:index, :new, :edit]
    resources "/carts", CartController, except: [:index, :new, :edit, :update]
    post "/cart_items", CartController, :add_cart_items
  end

  # Other scopes may use custom stacks.
  # scope "/api", EcommerceCourseWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser

      live_dashboard "/dashboard",
        metrics: EcommerceCourseWeb.Telemetry,
        additional_pages: [
          flame_on: FlameOn.DashboardPage
        ]
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
