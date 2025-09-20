defmodule Estagiei.Events do
  defstruct [:type, :payload]

  def new(type, payload) do
    %__MODULE__{type: type, payload: payload}
  end
end
