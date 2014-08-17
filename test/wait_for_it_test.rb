require "cutest"
require_relative "../lib/wait_for_it"

include WaitForIt

class Foo
  def self.bar
    :bar
  end

  def bar
    :bar
  end
end

scope do
  test "raise ExpectationError if the message was not passed" do
    foo = Foo.new

    assert_raise(WaitForIt::ExpectationError) do
      wait_for_it(foo, :bar) {}
    end

    assert wait_for_it(foo, :bar) { foo.bar }
  end
end

scope do
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
