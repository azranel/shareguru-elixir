defmodule Shareguru.PageController do
  use Shareguru.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
