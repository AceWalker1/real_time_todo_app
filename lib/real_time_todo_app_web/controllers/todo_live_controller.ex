defmodule RealTimeTodoAppWeb.TodoLiveController do
  use Phoenix.LiveView

  alias RealTimeTodoApp.Todo
  alias RealTimeTodoApp.Repo


  def render(assigns) do
    ~H"""
      <div>Create your Todo here!</div>
      <%= for todo <- @todos do%>
        <div><%= todo.name %></div><button phx-click = "delete" phx-value-id = {todo.id}>Delete Todo</button>
      <% end %>
      <form phx-submit = "create">
        <input type = "text" name = "name" id = "name">
        <button type = "submit">Create Todo!</button>
      </form>
    """
  end

  def mount(_params, _session, socket) do
    if connected?(socket), do: Phoenix.PubSub.subscribe(RealTimeTodoApp.PubSub, "todos")
    {:ok, assign(socket, todos: Repo.all(Todo))}
  end

  def handle_event("create", %{"name" => name}, socket) do
    todo = %Todo{name: name}
    case Repo.insert(todo) do
      {:ok, _message}->
        {:noreply, assign(socket, todos: Repo.all(Todo))}
        IO.inspect(name)

      {:error, changeset} ->
        {:noreply, changeset: changeset}
    end
    Phoenix.PubSub.broadcast(RealTimeTodoApp.PubSub, "todos", {[:todo, :created], todo})
    {:noreply, assign(socket, todos: Repo.all(Todo))}

  end

  def handle_event("delete", %{"id" => id}, socket) do
    todo = Repo.get!(Todo, id)
    Repo.delete(todo)

    Phoenix.PubSub.broadcast(RealTimeTodoApp.PubSub, "todos", {[:todo, :deleted], todo.id})

    {:noreply, assign(socket, todos: Repo.all(Todo))}

  end

  def handle_info({[:todo, :created], _todo}, socket) do
    {:noreply, assign(socket, todos: Repo.all(Todo))}
  end

  def handle_info({[:todo, :deleted], _todo_id}, socket) do
    {:noreply, assign(socket, todos: Repo.all(Todo))}
  end
end
