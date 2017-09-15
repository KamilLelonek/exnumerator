defmodule Exnumerator do
  defmacro __using__(opts) do
    quote location: :keep, bind_quoted: [values: opts[:values]] do
      @behaviour Ecto.Type
      
      def type,   do: :string
      def values, do: unquote(values)
      def sample, do: unquote(values) |> Enum.random

      for value <- values do
        def cast(unquote(value)), do: {:ok, unquote(value)}
        def load(unquote(value)), do: {:ok, unquote(value)}
        def dump(unquote(value)), do: {:ok, unquote(value)}
      end
      
      def cast(_), do: :error
      def load(_), do: :error
      def dump(_), do: :error
    end
  end
end
