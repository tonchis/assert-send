require "securerandom"

module WaitForIt
  ExpectationError = Class.new(StandardError)
  NOT_EXECUTED = SecureRandom.uuid

  def wait_for_it(object, message, &block)
    metaclass = object.singleton_class
    original = object.method(message)

    metaclass.send(:define_method, message) do |*args|
      throw(:executed, original.(*args))
    end

    res = catch(:executed) { yield; NOT_EXECUTED }

    res == NOT_EXECUTED ? (raise ExpectationError) : res
  ensure
    metaclass.send(:undef_method, message)
    metaclass.send(:define_method, message, original)
  end
end

