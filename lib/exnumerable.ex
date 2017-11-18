defmodule Exnumerator do
  defmacro __using__(opts) do
    quote location: :keep, bind_quoted: [values: opts[:values]] do
      @behaviour Ecto.Type

      def type,   do: :string
      def values, do: unquote(values)
      def sample, do: unquote(values) |> Enum.random

      if Enum.all?(values, &(is_atom(&1))) do
        for value <- values, atom = value, string = Atom.to_string(value) do
          def cast(unquote(atom)),   do: {:ok, unquote(string)}
          def cast(unquote(string)), do: {:ok, unquote(string)}
          def load(unquote(atom)),   do: {:ok, unquote(atom)}
          def dump(unquote(string)), do: {:ok, unquote(string)}
          def dump(unquote(atom)),   do: {:ok, unquote(string)}
        end
      else
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
