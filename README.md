# Sinatra::SessionHelpers

Helper methods for Sinatra's :sessions management

This is the same code than https://github.com/mjackson/sinatra-session, but adapted to use Sinatra's built-in `sessions`, instead of `Rack::Session::Cookie`.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sinatra-session_helpers'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sinatra-session_helpers

## Usage

### Helper Methods

```ruby
`session_start!`             -> Starts the session
`session_end!(destroy=true)` -> Ends the session. If `destroy` is false then 
                                session data will be preserved, even though future calls to `session?` will return false
`session?`                   -> Returns true if the session is valid
`session!`                   -> Redirects the client to the URL specified in 
                                the `session_fail` option unless the session is valid
```

### Settings

```
`session_fail`   -> A URL in your app that the client will be redirected to
                    when `session!` is called and the session is not valid.
                    Defaults to '/login'
```

You can force a specific secret key on the session:

```ruby
set :session_secret, '$ecR3t'
```

Or other optional parameters like this:

```ruby
set :sessions, :key          => 'sinatra.session',
               :path         => '/',
               :domain       => 'foo.com',
               :expire_after => 2592000, # 30 days
               :secret       => 'change_me'
```

## Examples

As with all Sinatra extensions, Sinatra::SessionHelpers may be used in both classic and modular-style apps. First, classic.

```ruby
require 'sinatra'
require 'sinatra/session_helpers'

set :session_fail, '/login'
set :session_secret, 'So0perSeKr3t!'
set :sessions, :key => 'my_app'

get '/' do
  session!
  'Hello, ' + session[:name] + '! Click <a href="/logout">here</a> to logout.'
end

get '/login' do
  if session?
    redirect '/'
  else
    '<form method="POST" action="/login">' +
    'Please enter your name: <input type="text" name="name">' +
    '<input type="submit" value="Submit">' +
    '</form>'
  end
end

post '/login' do
  if params[:name]
    session_start!
    session[:name] = params[:name]
    redirect '/'
  else
    redirect '/login'
  end
end

get '/logout' do
  session_end!
  redirect '/'
end
```

Modular apps use very similar code but must also mixin Sinatra::Session via Sinatra#register, like so:

```ruby
require 'sinatra/base'
require 'sinatra/session_helpers'

class MyApp < Sinatra::Base
  register Sinatra::Session

  # insert settings and routes here, same as in
  # classic example above
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/julienma/sinatra-session_helpers.


## License

Copyright 2016 Julien Ma

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

Based on software code Copyright 2012 Michael Jackson

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

The software is provided "as is", without warranty of any kind, express or implied, including but not limited to the warranties of merchantability, fitness for a particular purpose and non-infringement. In no event shall the authors or copyright holders be liable for any claim, damages or other liability, whether in an action of contract, tort or otherwise, arising from, out of or in connection with the software or the use or other dealings in the software.
