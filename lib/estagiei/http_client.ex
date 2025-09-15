defmodule Estagiei.HttpClient do
  def get(url) do
    case Req.get(url) do
      {:ok, response} -> {:ok, response.body}
      {:error, reason} -> {:error, reason}
    end
  end
end
