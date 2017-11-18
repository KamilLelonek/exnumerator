defmodule ExnumeratorTest do
  use ExUnit.Case

  @values ["sent", "read", "received", "delivered"]
  @values_as_atoms [:sent, :read, :received, :delivered]

  defmodule Message do
    use Exnumerator,
      values: ["sent", "read", "received", "delivered"]
  end

  defmodule MessageAsAtoms do
    use Exnumerator,
      values: [:sent, :read, :received, :delivered]
  end

  test "should store given values",
    do: assert Message.values == @values

  test "should return a random value",
    do: assert Message.sample in @values

  test "should store given values(MessageAsAtoms)",
    do: assert MessageAsAtoms.values == @values_as_atoms

  test "should return a random value(MessageAsAtoms)",
    do: assert MessageAsAtoms.sample in @values_as_atoms

  test "should argument given types" do
    assert Message.cast("sent")      == {:ok, "sent"}
    assert Message.load("received")  == {:ok, "received"}
    assert Message.dump("delivered") == {:ok, "delivered"}
  end

  test "should argument given types(MessageAsAtoms)" do
    assert MessageAsAtoms.cast(:sent)      == {:ok, "sent"}
    assert MessageAsAtoms.dump(:delivered) == {:ok, "delivered"}
  end

  test "atom should load as atom" do
    assert MessageAsAtoms.load(:received)  == {:ok, :received}
  end

  test "should not accept argument except string" do
    assert Message.cast(:sent)     == :error
    assert Message.load(:sent)     == :error
    assert Message.dump(:sent)     == :error
  end

  test "should not accept argument except atom(MessageAsAtoms)" do
    assert MessageAsAtoms.cast("sent")      == :error
    assert MessageAsAtoms.load("received")  == :error
    assert MessageAsAtoms.dump("delivered") == :error
  end

  test "should not cast unknown argument" do
    assert Message.cast("invalid") == :error
    assert Message.load("invalid") == :error
    assert Message.dump("invalid") == :error
    assert Message.cast(:invalid)  == :error
    assert Message.load(:invalid)  == :error
    assert Message.dump(:invalid)  == :error
  end
end
