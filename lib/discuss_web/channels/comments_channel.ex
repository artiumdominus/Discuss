defmodule DiscussWeb.CommentChannel do
  use DiscussWeb, :channel
  alias Discuss.Repo
  alias DiscussWeb.{Topic, Comment}

  def join("comments:" <> topic_id, _params, socket) do
    topic_id = String.to_integer(topic_id)
    topic = Repo.get(Topic, topic_id)
    IO.inspect topic
    {:ok, %{}, assign(socket, :topic, topic)}
  end

  def handle_in(topic, %{"content" => content}, socket) do
    topic = socket.assigns.topic

    changeset = topic
    |> Ecto.build_assoc(:comments)
    |> Comment.changeset(%{content: content})

    case Repo.insert(changeset) do
      {:ok, comment} ->
        {:reply, :ok, socket}
      {:error, _reason} ->
        {:reply, {:error, %{errors: changeset}}, socket}
    end
  end
end