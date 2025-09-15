defmodule Estagiei.Repo do
  use Ecto.Repo,
    otp_app: :estagiei,
    adapter: Ecto.Adapters.Postgres
end
