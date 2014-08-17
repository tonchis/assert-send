module WaitForIt
  ExpectationError = Class.new(StandardError)

  def wait_for_it(object, message, &block)
    metaclass = object.singleton_class
    original = object.method(message)

    metaclass.send(:define_method, message) do |*args|
      throw(:executed, original.(*args))
    end

    res = catch(:executed) { yield; :not_executed }

    res == :not_executed ? (raise ExpectationError) : res
  ensure
    metaclass.send(:undef_method, message)
    metaclass.send(:define_method, message, original)
  end
end

