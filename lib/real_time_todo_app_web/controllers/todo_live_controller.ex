defmodule RealTimeTodoAppWeb.TodoLiveController do
  use Phoenix.LiveView

  alias RealTimeTodoApp.Todo
  alias RealTimeTodoApp.Repo

  def render(assigns) do
    ~H"""
      <div>Create your Todo here!</div>
      <%= for todo <- @todos do%>
        <div><%= todo.name %></div>
      <% end %>
      <form phx-submit = "create">
        <input type = "text" name = "name" id = "name">
        <button type = "submit">Create Todo!</button>
      </form>
    """
  end

  def mount(_params, _session, socket) do
    {:ok, assign(socket, todos: Repo.all(Todo))}
  end

  def handle_event("create", %{"name" => name}, socket) do
    {:noreply, assign(socket, todos: Repo.all(Todo))}
    case Repo.insert(%Todo{name: name}) do
      {:ok, _message}->
        {:noreply, assign(socket, todos: Repo.all(Todo))}
        IO.inspect(name)

      {:error, changeset} ->
        {:noreply, changeset: changeset}

    end

  end

end
