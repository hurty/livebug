defmodule LivebugWeb.SearchLive do
  use Phoenix.LiveView

  alias LivebugWeb.Router.Helpers, as: Routes

  def render(assigns) do
    ~L"""
    <h1>Live redirect (now push_patch) query params bug</h1>

    <form phx-submit="search">
      <input type="text" name="query" placeholder="Search something">
      <button type="submit">Search</button>
    </form>

    <%= if @search_query do %>
      <p>Query = <%= @search_query %></p>
    <% end %>
    """
  end

  def mount(socket) do
    {:ok, assign(socket, :search_query, nil)}
  end

  def handle_params(params, _session, socket) do
    {:noreply, assign(socket, :search_query, params["query"])}
  end

  def handle_event("search", %{"query" => query}, socket) do
    search_path = Routes.live_path(socket, __MODULE__, query: query)
    {:noreply, push_patch(socket, to: search_path)}
  end
end
