require "cutest"
require_relative "../lib/wait_for_it"

include WaitForIt

class Foo
  def self.bar
    :class_bar
  end

  def self.bar_params(wat)
    wat
  end

  def bar
    :bar
  end
end

class Baz
  def boom
    Foo.bar
  end

  def no_boom
    :sorry
  end

  def boom_params
    Foo.bar_params("wat")
  end
end

scope do
  test "raise error if a method was not called" do
    assert_raise(WaitForIt::ExpectationError) do
      wait_for_it(Foo, :bar) {}
    end

    assert wait_for_it(Foo, :bar) { Foo.bar }
  end
end

scope do
  setup { Baz.new }

  test "spots the call deep into the stack" do |baz|
    assert wait_for_it(Foo, :bar) { baz.boom }

    assert_raise(WaitForIt::ExpectationError) do
      wait_for_it(Foo, :bar) { baz.no_boom }
    end
  end

  test "respect arguments in the call" do |baz|
    assert wait_for_it(Foo, :bar_params) { baz.boom_params }
  end
end

