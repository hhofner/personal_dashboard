defmodule HelloHans.Repo do
  use Ecto.Repo,
    otp_app: :hello_hans,
    adapter: Ecto.Adapters.SQLite3
end
