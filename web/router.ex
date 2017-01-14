defmodule PhoenixLoggerTest.Router do
  use PhoenixLoggerTest.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PhoenixLoggerTest do
    pipe_through :api

    get "/normal", PageController, :normal
    get "/redirct", PageController, :xredirct
    get "/halts", PageController, :halts
    get "/raises", PageController, :raises

    get "/plug_normal", PageController, :plug_normal
    get "/plug_redirects", PageController, :plug_redirects
    get "/plug_halts", PageController, :plug_halts
    get "/plug_raises", PageController, :plug_raises
  end
end
