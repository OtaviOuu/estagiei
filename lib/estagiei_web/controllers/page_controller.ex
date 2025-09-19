defmodule EstagieiWeb.RedirectController do
  use EstagieiWeb, :controller

  def to_index(conn, _params) do
    redirect(conn, to: ~p"/estagios")
  end
end
