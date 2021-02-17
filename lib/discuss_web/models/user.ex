defmodule DiscussWeb.User do
  use DiscussWeb, :model

  schema "users" do
    field :email, :string
    field :provider, :string
    field :token, :string

    timestamps()

    has_many :topics, DiscussWeb.Topic
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:email, :provider, :token])
    |> validate_required([:email, :provider, :token])
  end
end