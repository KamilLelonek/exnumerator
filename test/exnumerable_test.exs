defmodule ExnumerableTest do
  use ExUnit.Case

  defmodule Message do
    use Exnumerable,
      values: [:sent, :read, :received, :delivered]
  end

  test "should store given values",
    do: assert Message.values == [:sent, :read, :received, :delivered]

  test "should augment given types" do
    assert Message.cast("sent")      == {:ok, :sent}
    assert Message.cast(:read)       == {:ok, :read}
    assert Message.load("received")  == {:ok, :received}
    assert Message.dump("delivered") == {:ok, "delivered"}
    assert Message.dump(:sent)       == {:ok, "sent"}
  end

  test "should not cast unknown argument" do
    assert Message.cast("invalid") == :error
    assert Message.cast(:invalid)  == :error
    assert Message.load("invalid") == :error
    assert Message.load(:invalid)  == :error
    assert Message.dump("invalid") == :error
    assert Message.dump(:invalid)  == :error
  end
end
