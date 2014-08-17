require "cutest"
require_relative "../lib/wait_for_it"

include WaitForIt

scope do
  class Foo
    def bar
      :bar
    end
  end

  test "raise ExpectationError if the message was not passed" do
    foo = Foo.new

    assert_raise(WaitForIt::ExpectationError) do
      wait_for_it(foo, :bar) {}
    end

    assert wait_for_it(foo, :bar) { foo.bar }
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
    assert wait_for_it(Foo, :bar) { baz.yes }

    assert_raise(WaitForIt::ExpectationError) do
      wait_for_it(Foo, :bar) { baz.no }
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
    wait_for_it(Numberz, :one) do
      assert_equal 5, Numberz.successor(4)
    end

    assert_equal 5, wait_for_it(Numberz, :one) { Numberz.successor(4) }
  end
end
