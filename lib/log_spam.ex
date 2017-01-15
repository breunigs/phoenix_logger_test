defmodule LogSpam do
  require Logger

  def phoenix_controller_call(:start, compile_metadata, runtime_metadata) do
    # XXX: happens *after*     [info] GET /redirect     :(


    # IO.inspect compile_metadata
    # %{file: "/home/stefan/code/phoenix_logger_test/web/controllers/page_controller.ex",
    #   function: "call/2", line: 2, module: PhoenixLoggerTest.PageController}

    # IO.inspect runtime_metadata
    # %{conn: %Plug.Conn{adapter: {Plug.Adapters.Cowboy.Conn, :...}, assigns: %{},
    #    before_send: [#Function<1.108484889/1 in PhoenixLoggerTest.Endpoint.sleep_a_bit/2>,
    #     #Function<1.97503433/1 in Plug.Logger.call/2>], body_params: %{},
    #    cookies: %Plug.Conn.Unfetched{aspect: :cookies}, halted: false,
    #    host: "localhost", method: "GET", owner: #PID<0.414.0>, params: %{},
    #    path_info: ["redirect"], path_params: %{}, peer: {{127, 0, 0, 1}, 35424},
    #    port: 4000,
    #    private: %{PhoenixLoggerTest.Router => {[], %{}},
    #      :phoenix_action => :xredirect,
    #      :phoenix_controller => PhoenixLoggerTest.PageController,
    #      :phoenix_endpoint => PhoenixLoggerTest.Endpoint, :phoenix_format => "json",
    #      :phoenix_pipelines => [:api],
    #      :phoenix_route => #Function<2.33744376/1 in PhoenixLoggerTest.Router.match_route/4>,
    #      :phoenix_router => PhoenixLoggerTest.Router,
    #      :plug_session_fetch => #Function<1.46198565/1 in Plug.Session.fetch_session/1>},
    #    query_params: %{}, query_string: "", remote_ip: {127, 0, 0, 1},
    #    req_cookies: %Plug.Conn.Unfetched{aspect: :cookies},
    #    req_headers: [{"host", "localhost:4000"}, {"user-agent", "curl/7.51.0"},
    #     {"accept", "*/*"}], request_path: "/redirect", resp_body: nil,
    #    resp_cookies: %{},
    #    resp_headers: [{"cache-control", "max-age=0, private, must-revalidate"},
    #     {"x-request-id", "r169588dlhc7sk6vatbm2l5cs36ud2uo"}], scheme: :http,
    #    script_name: [],
    #    secret_key_base: "09IEzc7CVnFAhcYhjHmJTltytWs4PRR6Lp69YoVzF7ai9rdoZBFH0tsyR4t23xIg",
    #    state: :unset, status: nil}, log_level: :debug}


    Logger.warn "------------------------------------------------- starting request"


    # * `compile_metadata` is a map of compile-time metadata about the environment
    #   where `instrument/3` has been called. It contains the module where the
    #   instrumentation is happening (under the `:module` key), the file and line
    #   (`:file` and `:line`), and the function inside which the instrumentation
    #   is happening (under `:function`). This information can be used arbitrarily
    #   by the callback.
    # * `runtime_metadata` is a map of runtime data that the instrumentation
    #   passes to the callbacks. This can be used for any purposes: for example,
    #   when instrumenting the rendering of a view, the name of the view could be
    #   passed in these runtime data so that instrumenters know which view is
    #   being rendered (`instrument(:view_render, %{view: "index.html"}, fn
    #   ...)`).
    :look_i_can_pass_data
  end

  def phoenix_controller_call(:stop, time_diff, result_of_before_callback) do
    # XXX: happens *before*     Sent 500 in 2022ms (or other register_before_send)

    Logger.warn "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ finished request"
    # * `time_diff` is an integer representing the time it took to execute the
    #   instrumented function **in native units**.
    # * `result_of_before_callback` is the return value of the "before" clause of
    #   the same `event_callback`. This is a means of passing data from the
    #   "before" clause to the "after" clause when instrumenting.

    # IO.inspect time_diff |> System.convert_time_unit(:native, :milliseconds)

    :look_i_can_pass_data = result_of_before_callback

    :ok
  end
end
