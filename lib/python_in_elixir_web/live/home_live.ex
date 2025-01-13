defmodule PythonInElixirWeb.HomeLive do
  use PythonInElixirWeb, :live_view
  use Export.Python

  @impl true
  def mount(_params, _session, socket) do
    # I think this tries to use python2 so we need to specify the python executable path
    {:ok, py} = Python.start(python_path: Path.expand("python"), python: System.get_env("PYTHON_EXECUTABLE_PATH"))

    val = py |> Python.call("random_number", "get_random_number", [])

    socket =
      socket
      |> assign(
        py: py,
        random_number: val
      )

    {:ok, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <h1 class="text-2xl font-bold">
      <%= @random_number %>
    </h1>
    <button phx-click="update" class="bg-blue-500 text-white px-4 py-2 rounded">Update</button>
    """
  end

  @impl true
  def handle_event("update", _params, socket) do
    val = socket.assigns.py |> Python.call("random_number", "get_random_number", [])

    socket =
      socket
      |> assign(random_number: val)

    {:noreply, socket}
  end
end
