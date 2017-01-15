defmodule PhoenixLoggerTest.Endpoint do
  use Phoenix.Endpoint, otp_app: :phoenix_logger_test

  socket "/socket", PhoenixLoggerTest.UserSocket

  # Serve at "/" the static files from "priv/static" directory.
  #
  # You should set gzip to true if you are running phoenix.digest
  # when deploying your static files in production.
  plug Plug.Static,
    at: "/", from: :phoenix_logger_test, gzip: false,
    only: ~w(css fonts images js favicon.ico robots.txt)

  # Code reloading can be explicitly enabled under the
  # :code_reloader configuration of your endpoint.
  if code_reloading? do
    plug Phoenix.CodeReloader
  end

  # plug :sleep_a_bit
  # defp sleep_a_bit(conn, _) do
  #   Plug.Conn.register_before_send(conn, fn conn ->
  #     # delay the "Sent 302 in 146µs" output of Plug.Logger a bit, to see if
  #     # we are really the last command to be called in LogSpam
  #     Process.sleep(2000)
  #     conn
  #   end)
  # end

  plug Plug.RequestId
  plug Plug.Logger
  plug :sleep_a_bit

  defp sleep_a_bit(conn, _) do
    Plug.Conn.register_before_send(conn, fn conn ->
      # delay the "Sent 302 in 146µs" output of Plug.Logger a bit, to see if
      # we are really the last command to be called in LogSpam
      Process.sleep(2000)
      conn
    end)
  end

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Poison

  plug Plug.MethodOverride
  plug Plug.Head

  # The session will be stored in the cookie and signed,
  # this means its contents can be read but not tampered with.
  # Set :encryption_salt if you would also like to encrypt it.
  plug Plug.Session,
    store: :cookie,
    key: "_phoenix_logger_test_key",
    signing_salt: "8xpR2wp7"

  plug PhoenixLoggerTest.Router
end
