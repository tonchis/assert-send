require "cutest"
require_relative "../lib/assert_send"

include AssertSend

scope do
  class Foo
    def bar
      :bar
    end
  end

  test "raise ExpectationError if the message was not passed" do
    foo = Foo.new

    assert_raise(AssertSend::ExpectationError) do
      assert_send(foo, :bar) {}
    end

    assert assert_send(foo, :bar) { foo.bar }
  end
end

scope do
  class Foo
    def self.bar
      :bar
    end
  end

  class Baz
    def yes
      Foo.bar
    end

    def no
      :sorry
    end
  end

  setup { Baz.new }

  test "spots the message deep into the stack" do |baz|
    assert assert_send(Foo, :bar) { baz.yes }

    assert_raise(AssertSend::ExpectationError) do
      assert_send(Foo, :bar) { baz.no }
    end
  end
end

scope do
  class Numberz
    def self.one
      1
    end

    def self.successor(n)
      n + Numberz.one
    end
  end

  test "dont mess with the execution chain" do
    assert_send(Numberz, :one) do
      assert_equal 5, Numberz.successor(4)
    end

    assert_equal 5, assert_send(Numberz, :one) { Numberz.successor(4) }
  end
end
