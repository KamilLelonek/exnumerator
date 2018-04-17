defmodule Exnumerator do
  alias Exnumerator.{StringListEnum, AtomListEnum, KeywordListEnum}

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
      def sample, do: Enum.random(values())

      @doc """
      Returns the first value for the enum.
      """
      def first, do: List.first(values())

      @impl true
      def type, do: :string

      @impl true
      def cast(term), do: Exnumerator.cast(values(), term)

      @impl true
      def dump(term), do: Exnumerator.dump(values(), term)

      @impl true
      def load(term), do: Exnumerator.load(values(), term)
    end
  end

  def cast(values, term), do: run(:cast, values, term)
  def load(values, term), do: run(:load, values, term)
  def dump(values, term), do: run(:dump, values, term)

  defp run(action, values, term) do
    cond do
      Keyword.keyword?(values) -> apply(KeywordListEnum, action, [values, term])
      Enum.all?(values, &is_atom(&1)) -> apply(AtomListEnum, action, [values, term])
      is_list(values) -> apply(StringListEnum, action, [values, term])
      true -> nil
    end
  end
end
