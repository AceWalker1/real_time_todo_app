defmodule RealTimeTodoApp.Repo do
  use Ecto.Repo,
    otp_app: :real_time_todo_app,
    adapter: Ecto.Adapters.Postgres
end
