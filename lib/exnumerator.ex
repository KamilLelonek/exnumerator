defmodule Exnumerator do
  defmacro __using__(opts) do
    quote location: :keep, bind_quoted: [values: opts[:values]] do
      @behaviour Ecto.Type

      @doc """
      Returns all possible values for the enum.
      """
      def values, do: unquote(values)

      @doc """
      Returns a random value for the enum.
      """
      def sample, do: unquote(values) |> Enum.random()

      @impl true
      def type, do: :string

      @impl true
      def cast(term)

      @impl true
      def dump(term)

      @impl true
      def load(term)

      cond do
        Keyword.keyword?(values) ->
          for {name, value} <- values, string = Atom.to_string(name) do
            def cast(unquote(name)), do: {:ok, unquote(name)}
            def cast(unquote(value)), do: {:ok, unquote(name)}
            def cast(unquote(string)), do: {:ok, unquote(name)}
            def load(unquote(value)), do: {:ok, unquote(name)}
            def dump(unquote(name)), do: {:ok, unquote(value)}
            def dump(unquote(value)), do: {:ok, unquote(value)}
            def dump(unquote(string)), do: {:ok, unquote(value)}
          end

        Enum.all?(values, &is_atom(&1)) ->
          for value <- values, atom = value, string = Atom.to_string(value) do
            def cast(unquote(atom)), do: {:ok, unquote(atom)}
            def cast(unquote(string)), do: {:ok, unquote(atom)}
            def load(unquote(string)), do: {:ok, unquote(atom)}
            def dump(unquote(string)), do: {:ok, unquote(string)}
            def dump(unquote(atom)), do: {:ok, unquote(string)}
          end

        true ->
          for value <- values do
            def cast(unquote(value)), do: {:ok, unquote(value)}
            def load(unquote(value)), do: {:ok, unquote(value)}
            def dump(unquote(value)), do: {:ok, unquote(value)}
          end
      end

      def cast(_), do: :error
      def load(_), do: :error
      def dump(_), do: :error
    end
  end
end
