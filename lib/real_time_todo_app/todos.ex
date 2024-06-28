defmodule RealTimeTodoApp.Todo do
  use Ecto.Schema
  import Ecto.Changeset

  schema "todo" do
    field :name, :string

    timestamps()
  end

  def changeset(todo, params) do
    todo
    |>cast(params, [:name])
    |>validate_required([:name])
  end
end
