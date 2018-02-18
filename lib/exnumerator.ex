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
      def sample, do: values() |> Enum.random()

      @impl true
      def type, do: :string

      @impl true
      def cast(term) do
        values() |> Exnumerator.cast(term)
      end

      @impl true
      def dump(term) do
        values() |> Exnumerator.dump(term)
      end

      @impl true
      def load(term) do
        values() |> Exnumerator.load(term)
      end
    end
  end

  def cast(values, term) do
    run(:cast, values, term)
  end

  def load(values, term) do
    run(:load, values, term)
  end

  def dump(values, term) do
    run(:dump, values, term)
  end

  defp run(action, values, term) do
    cond do
      Keyword.keyword?(values) -> apply(KeywordListEnum, action, [values, term])
      Enum.all?(values, &is_atom(&1)) -> apply(AtomListEnum, action, [values, term])
      is_list(values) -> apply(StringListEnum, action, [values, term])
      true -> nil
    end
  end
end
