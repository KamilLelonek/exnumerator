defmodule ExnumeratorTest do
  use ExUnit.Case

  @values_strings ["sent", "read", "received", "delivered"]
  @values_atoms [:sent, :read, :received, :delivered]
  @values_keywords [sent: "S", read: "READ", received: "R", delivered: "D"]

  defmodule MessageAsString do
    use Exnumerator, values: ["sent", "read", "received", "delivered"]
  end

  defmodule MessageAsAtom do
    use Exnumerator, values: [:sent, :read, :received, :delivered]
  end

  defmodule MessageAsKeywords do
    use Exnumerator, values: [sent: "S", read: "READ", received: "R", delivered: "D"]
  end

  test "should store given values", do: assert(MessageAsString.values() == @values_strings)

  test "should return a random value", do: assert(MessageAsString.sample() in @values_strings)

  test "should store given values(MessageAsAtoms)",
    do: assert(MessageAsAtom.values() == @values_atoms)

  test "should return a random value(MessageAsAtoms)",
    do: assert(MessageAsAtom.sample() in @values_atoms)

  test "should argument given types" do
    assert MessageAsString.cast("sent") == {:ok, "sent"}
    assert MessageAsString.load("received") == {:ok, "received"}
    assert MessageAsString.dump("delivered") == {:ok, "delivered"}
  end

  test "should argument given types(MessageAsAtoms)" do
    assert MessageAsAtom.cast(:sent) == {:ok, :sent}
    assert MessageAsAtom.dump(:delivered) == {:ok, "delivered"}
  end

  test "should not accept argument except string" do
    assert MessageAsString.cast(:sent) == :error
    assert MessageAsString.load(:sent) == :error
    assert MessageAsString.dump(:sent) == :error
  end

  test "should load string and convert to atom when is MessageAsAtom" do
    refute MessageAsAtom.load("received") == {:ok, "received"}
    assert MessageAsAtom.load("received") == {:ok, :received}
  end

  test "should load string and not convert to atom when is MessageAsString" do
    refute MessageAsString.load("received") == {:ok, :received}
    assert MessageAsString.load("received") == {:ok, "received"}
  end

  test "should accept string for values in atom for cast and dump" do
    assert MessageAsAtom.cast("sent") == {:ok, :sent}
    assert MessageAsAtom.dump("delivered") == {:ok, "delivered"}
  end

  test "should not cast unknown argument" do
    assert MessageAsString.cast("invalid") == :error
    assert MessageAsString.load("invalid") == :error
    assert MessageAsString.dump("invalid") == :error
    assert MessageAsAtom.cast(:invalid) == :error
    assert MessageAsAtom.load(:invalid) == :error
    assert MessageAsAtom.dump(:invalid) == :error
  end

  describe "keywords" do
    test "should store given values" do
      assert MessageAsKeywords.values() == @values_keywords
    end

    test "should return a random value" do
      assert MessageAsKeywords.sample() in @values_keywords
    end

    test "should cast atom, string, or raw value" do
      assert MessageAsKeywords.cast(:sent) == {:ok, :sent}
      assert MessageAsKeywords.cast("sent") == {:ok, :sent}
      assert MessageAsKeywords.cast("S") == {:ok, :sent}
    end

    test "should not cast non-whitelisted values" do
      assert MessageAsKeywords.cast(:invalid) == :error
      assert MessageAsKeywords.cast("invalid") == :error
    end

    test "should dump atom, string, or raw value" do
      assert MessageAsKeywords.dump(:sent) == {:ok, "S"}
      assert MessageAsKeywords.dump("sent") == {:ok, "S"}
      assert MessageAsKeywords.dump("S") == {:ok, "S"}
    end

    test "should not dump non-whitelisted values" do
      assert MessageAsKeywords.dump(:invalid) == :error
      assert MessageAsKeywords.dump("invalid") == :error
    end

    test "should load only the raw value" do
      assert MessageAsKeywords.load("S") == {:ok, :sent}
      assert MessageAsKeywords.load(:sent) == :error
      assert MessageAsKeywords.load("sent") == :error
    end
  end
end
