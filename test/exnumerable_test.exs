defmodule ExnumeratorTest do
  use ExUnit.Case

  @values_strings ["sent", "read", "received", "delivered"]
  @values_atoms   [:sent, :read, :received, :delivered]

  defmodule MessageAsString do
    use Exnumerator,
      values: ["sent", "read", "received", "delivered"]
  end

  defmodule MessageAsAtom do
    use Exnumerator,
      values: [:sent, :read, :received, :delivered]
  end

  test "should store given values",
    do: assert MessageAsString.values == @values_strings

  test "should return a random value",
    do: assert MessageAsString.sample in @values_strings

  test "should store given values(MessageAsAtoms)",
    do: assert MessageAsAtom.values == @values_atoms

  test "should return a random value(MessageAsAtoms)",
    do: assert MessageAsAtom.sample in @values_atoms

  test "should argument given types" do
    assert MessageAsString.cast("sent")      == {:ok, "sent"}
    assert MessageAsString.load("received")  == {:ok, "received"}
    assert MessageAsString.dump("delivered") == {:ok, "delivered"}
  end

  test "should argument given types(MessageAsAtoms)" do
    assert MessageAsAtom.cast(:sent)      == {:ok, "sent"}
    assert MessageAsAtom.dump(:delivered) == {:ok, "delivered"}
  end

  test "atom should load as atom" do
    assert MessageAsAtom.load(:received) == {:ok, :received}
  end

  test "should not accept argument except string" do
    assert MessageAsString.cast(:sent) == :error
    assert MessageAsString.load(:sent) == :error
    assert MessageAsString.dump(:sent) == :error
  end

  test "should not accept argument except atom(MessageAsAtoms) in load" do
    assert MessageAsAtom.load("received")  == :error
  end

  test "should accept string for values in atom for cast and dump" do
    assert MessageAsAtom.cast("sent")      == {:ok, "sent"}
    assert MessageAsAtom.dump("delivered") == {:ok, "delivered"}
  end

  test "should not cast unknown argument" do
    assert MessageAsString.cast("invalid") == :error
    assert MessageAsString.load("invalid") == :error
    assert MessageAsString.dump("invalid") == :error
    assert MessageAsAtom.cast(:invalid)    == :error
    assert MessageAsAtom.load(:invalid)    == :error
    assert MessageAsAtom.dump(:invalid)    == :error
  end
end
