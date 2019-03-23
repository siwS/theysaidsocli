# theysaidso

Powered by:
<span style="z-index:50;font-size:0.9em;"><img src="https://theysaidso.com/branding/theysaidso.png" height="20" width="20" alt="theysaidso.com"/><a href="https://theysaidso.com" title="Powered by quotes from theysaidso.com" style="color: #9fcc25; margin-left: 4px; vertical-align: middle;">theysaidso.com</a></span>


This is a simple CLI gem to get quotes from the TheysaidsocliAPI.
If you need some inspiration during your day, just pick your daily quote from your command line!

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'theysaidsocli'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install theysaidso

## Usage

You can run in your command line:

- `theysaidso` : gets you the Quote of the day!
- `Theysaidsocli-cat` : gets you all the available quote categories
- `Theysaidsocli-cat life` : gets you a quote from the "life" category


### TODO:

The API is rate-limited so with the free version you can make 10requests per hour.
I doubt people will need more than that in a CLI, but I will implement at some point passing an API key to get unlimited quotes

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/theysaidso. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Theysaidsocliproject’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/theysaidso/blob/master/CODE_OF_CONDUCT.md).


