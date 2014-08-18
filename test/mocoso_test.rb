require "cutest"
require "mocoso"
require_relative "../lib/assert_send"

include Mocoso
include AssertSend

class Foo
  def self.foo
    "le foo"
  end

  def self.bar
    Foo.foo
  end

  def self.baz(arg)
    arg
  end
end

test "Mocoso#stub" do
  stub(Foo, :foo, "wow") do
    assert_equal "wow", assert_send(Foo, :foo) { Foo.bar }
  end

  assert_equal "le foo", assert_send(Foo, :foo) { Foo.bar }
end

test "Mocoso#expect" do
  # Mocoso will raise an exception because the argument used is not the same as the one in the expectation.
  # However, AssertSend will not throw any errors because the message was indeed passed.
  assert_raise(Mocoso::ExpectationError) do
    expect(Foo, :baz, with: ["wat"]) do
      assert_send(Foo, :baz) { Foo.baz("not") }
    end
  end

  # Now, Mocoso won't raise an error because the stub set in the expectation is never invoked,
  # but AssertSend is going to throw an error because it was expecting Foo to receive :baz.
  assert_raise(AssertSend::ExpectationError) do
    expect(Foo, :baz, with: ["wat"]) do
      assert_send(Foo, :baz) {}
    end
  end
end

test "using Mocoso inside AssertSend will raise AssertSend::ExpectationError" do
  assert_raise(AssertSend::ExpectationError) do
    assert_send(Foo, :foo) do
      stub(Foo, :foo, "wow") { Foo.bar }
    end
  end
end
