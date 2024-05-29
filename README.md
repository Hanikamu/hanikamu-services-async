# Hanikamu Services Async
Async offers an simple way to enqueue a Hanikamu::Service class as an ActiveJob  

Just including the module in your service will provide an easy interface to enqueue the jobs


Basic Example:

```ruby
class MyService < Hanikamu::Service
  include Hanikamu::Services::Async

  attribute hey: Types::String

  def call!
    # do nothing
  end
end

# Run your service sync
MyService.call!(hey: 'hola')

# Run your service as an ActiveJob
MyService::Async.call!(hey: 'hola')

```