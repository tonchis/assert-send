module AssertSend
  ExpectationError = Class.new(StandardError)

  def assert_send(object, message, &block)
    metaclass = object.singleton_class
    original = object.method(message)
    executed = nil

    metaclass.send(:define_method, message) do |*args|
      executed = true
      original.(*args)
    end

    res = yield

    executed ? res : (raise ExpectationError, "Expected #{object} to receive message :#{message}")
  ensure
    metaclass.send(:undef_method, message)
    metaclass.send(:define_method, message, original)
  end
end

