# Wait for it

This little piece of work helps you know if an expected was passed somewhere down your call stack.

### Usage

It's quite simple. Imagine you want to make sure `user.save` gets called.

```ruby
user = User.find(...)

wait_for_it(user, :save) do
  your_dangerous_code!
end
```

If `your_dangerous_code!` doesn't call `user.save` in the call stack, it'll raise a `WaitForIt::ExpectationError`.

It's important to know that this will **not** stub your method. The original implementation it's never tampered with.

If you're looking to stub things, I suggest you having a look at [frodsan/mocoso](https://github.com/frodsan/mocoso).

### Installation

```bash
gem install wait_for_it
```
