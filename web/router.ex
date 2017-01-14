defmodule PhoenixLoggerTest.Router do
  use PhoenixLoggerTest.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", PhoenixLoggerTest do
    pipe_through :api
  end
end
