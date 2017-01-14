defmodule PhoenixLoggerTest.PageController do
  use PhoenixLoggerTest.Web, :controller

  def normal(conn, _params) do
    json conn, %{"whatever" => "derp"}
  end

  def xredirect(conn, _params) do
    conn |> redirect(to: "/?normal")
  end

  def halts(conn, _params) do
    conn |> halt
  end

  def raises(conn, _params) do
    raise "coding error"
  end

  plug :working_plug when action == :plug_normal
  def plug_normal(conn, _params) do
    json conn, %{"magic" => "in plug"}
  end
  defp working_plug(conn, _) do
    conn |> put_flash(:info, "hi from plug")
  end

  plug :redirecting_plug when action == :plug_redirects
  def plug_redirects(conn, _params) do
    json conn, %{"magic" => "in plug"}
  end
  defp redirecting_plug(conn, _) do
    conn |> redirect(to: "/?from_plug")
  end

  plug :halting_plug when action == :plug_halts
  def plug_halts(conn, _params) do
    json conn, %{"magic" => "in plug"}
  end
  defp halting_plug(conn, _) do
    conn |> halt
  end

  plug :raising_plug when action == :plug_raises
  def plug_raises(conn, _params) do
    json conn, %{"magic" => "in plug"}
  end
  defp raising_plug(conn, _) do
    raise "error from plug"
  end
end
