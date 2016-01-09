defmodule Exnumterator do
  defmacro __using__(opts) do
    quote location: :keep, bind_quoted: [values: opts[:values]] do
      @behaviour Ecto.Type

      def type,   do: :string
      def values, do: unquote(values)

      for value <- values, atom = value, string = Atom.to_string(value) do
        def cast(unquote(string)), do: {:ok, unquote(atom)}
        def cast(unquote(atom)),   do: {:ok, unquote(atom)}
        def load(unquote(string)), do: {:ok, unquote(atom)}
        def dump(unquote(string)), do: {:ok, unquote(string)}
        def dump(unquote(atom)),   do: {:ok, unquote(string)}
      end

      def cast(_), do: :error
      def load(_), do: :error
      def dump(_), do: :error
    end
  end
end
