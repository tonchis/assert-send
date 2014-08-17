# Wait for it

This little piece of work helps you know if an expected was passed somewhere down your call stack.

## Usage

It's quite simple. Imagine you want to know if `Foo.bar` is called.

```ruby
wait_for_it(Foo, :bar) do
  your_scary_method
end
```

If `your_scary_method` doesn't call `Foo.bar` in it's call stack, this will raise an `WaitForIt::ExpectationError`.

## Installation

```bash
gem install wait_for_it
```

## Acknowledgements
