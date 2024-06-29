defmodule RealTimeTodoApp.Repo.Migrations.CreateTodoTable do
  use Ecto.Migration

  def change do
    create table("todo") do
      add :name, :string

      timestamps()
    end

  end
end
