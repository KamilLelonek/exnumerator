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
          for {key, value} <- values, key_string = Atom.to_string(key) do
            def cast(unquote(key)), do: {:ok, unquote(key)}
            def cast(unquote(value)), do: {:ok, unquote(key)}
            def cast(unquote(key_string)), do: {:ok, unquote(key)}

            def load(unquote(value)), do: {:ok, unquote(key)}

            def dump(unquote(key)), do: {:ok, unquote(value)}
            def dump(unquote(value)), do: {:ok, unquote(value)}
            def dump(unquote(key_string)), do: {:ok, unquote(value)}
          end

        Enum.all?(values, &is_atom(&1)) ->
          for value <- values, value_string = Atom.to_string(value) do
            def cast(unquote(value)), do: {:ok, unquote(value)}
            def cast(unquote(value_string)), do: {:ok, unquote(value)}

            def load(unquote(value_string)), do: {:ok, unquote(value)}

            def dump(unquote(value_string)), do: {:ok, unquote(value_string)}
            def dump(unquote(value)), do: {:ok, unquote(value_string)}
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
