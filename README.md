# Wait for it

This little piece of work helps you know if an expected message was passed somewhere down your call stack.

### Usage

It's quite simple. Imagine you want to make sure `user.save` gets called.

```ruby
include AssertSend

user = User.find(...)

assert_send(user, :save) do
  your_dangerous_code!
end
```

If `your_dangerous_code!` doesn't call `user.save` in the call stack, it'll raise a `AssertSend::ExpectationError`.

It's important to know that this will **not** stub your method. The original implementation it's never tampered with.

If you're looking to stub things, I suggest you having a look at [frodsan/mocoso](https://github.com/frodsan/mocoso).

### Installation

```
gem install assert-send
```
