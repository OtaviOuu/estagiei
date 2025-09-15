defmodule Estagiei.Parser do
  def parse_html(html) do
    case Floki.parse_document(html) do
      {:ok, document} -> {:ok, document}
      {:error, reason} -> {:error, reason}
    end
  end
end
