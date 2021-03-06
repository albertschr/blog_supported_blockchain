defmodule BlogWeb.Router do
  @moduledoc """
    router of blogweb!

    http://ahasmarter.com
  """
  use BlogWeb, :router
  import Phoenix.LiveView.Router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(Phoenix.LiveView.Flash)
    # plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
    # plug(CORSPlug, origin: "http://ahasmarter.com")
    # plug :put_layout, {DemoWeb.LayoutView, :app}
  end

  pipeline :api do
    plug(:accepts, ["urlencoded", "json"])
    plug(CORSPlug, origin: "http://ahasmarter.com")
  end

  pipeline :auth do
    plug(Auth.AuthAccessPipeline)
  end

  scope "/elixir_web", BlogWeb do
    pipe_through([:browser, :api])
    get("/articles/:id", PageController, :show)
  end

  # scope "/ycy", BlogWeb do
  #   pipe_through([:browser])
  #   get("/messages", YcyController, :show)
  # en

  scope "/", BlogWeb do
    pipe_through([:browser])
    live("/pacman", PacmanLive)
  end

  scope "/api/v1", BlogWeb do
    pipe_through([:browser, :api])
    post("/articles", ArticleController, :show)
    post("/test", ArticleController, :test)
    resources("/sessions", SessionController, only: [:new, :create])
    # get an article by id
    get("/articles/:id", ArticleController, :show)
  end

  # scope "/api/v1", BlogWeb do
  #   pipe_through([:browser, :api])
  #   get("/ycy/messages", YcyMessageController, :show)
  #   post("/ycy/messages/create", YcyMessageController, :create)
  #   post("/ycy/groups/create", YcyGroupController, :create)
  #   # get an group info by id
  #   get("/ycy/groups/:puid", YcyGroupController, :show)
  #   get("/ycy/users/:puid", YcyUserController, :show)
  #   post("/ycy/users/create", YcyUserController, :create)
  #   post("/ycy/users/transfer", YcyUserController, :transfer)
  # end

  # scope "/api/v1", BlogWeb do
  #   pipe_through([:browser, :api])

  #   get("/ycy/real_estates", YcyRealEstateController, :show)
  #   get("/ycy/real_estate/:name", YcyRealEstateController, :show)
  #   post("/ycy/real_estate/buy/:buyer", YcyRealEstateController, :buy)
  #   post("/ycy/real_estate/update", YcyRealEstateController, :update)
  # end

  scope "/api/v1", BlogWeb do
    pipe_through([:browser, :api, :auth])
    get("/sessions/logout", SessionController, :delete)
    get("/users/:id", UserController, :show)
    get("/", PageController, :index)
    get("/users/", UserController, :load_current_user)

    # create an article by id
    post("/articles/create", ArticleController, :create)
  end

  # Other scopes may use custom stacks.
  # scope "/api", BlogWeb do
  #   pipe_through :api
  # end
end
