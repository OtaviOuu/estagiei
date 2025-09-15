defmodule EstagieiWeb.PageController do
  use EstagieiWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
