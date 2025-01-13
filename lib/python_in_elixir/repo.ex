defmodule PythonInElixir.Repo do
  use Ecto.Repo,
    otp_app: :python_in_elixir,
    adapter: Ecto.Adapters.Postgres
end
