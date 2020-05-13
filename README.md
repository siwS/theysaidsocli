# theysaidso

Powered by:
<span style="z-index:50;font-size:0.9em;"><img src="https://theysaidso.com/branding/theysaidso.png" height="20" width="20" alt="theysaidso.com"/><a href="https://theysaidso.com" title="Powered by quotes from theysaidso.com" style="color: #9fcc25; margin-left: 4px; vertical-align: middle;">theysaidso.com</a></span>


This is a CLI to get quotes from the [theysaidso](https://theysaidso.com/api/) API.
If you need some inspiration during your day, just get your daily quote from your command line!

## Installation

You can install by running:

    $ gem install theysaidsocli

## Usage

You can run in your command line:

- `theysaidsocli` : gets you the Quote of the day!
- `Theysaidsocli -cat` : gets you all the available quote categories
- `Theysaidsocli -cat life` : gets you a quote from the "life" category


### TODO:

- [ ] The [theysaidso](https://theysaidso.com/api/) API is rate-limited. With the free version you can only make 10 requests per hour. I need to implement passing an API key to get unlimited quotes.

## Development

1. Checking out the repo
2. Run `bin/setup` to install dependencies. 
3. Then, using `rake spec` you can run the tests. 
4. You can also run `bin/console` for an interactive prompt.
5. To install the gem on your local machine, run `bundle exec rake install`. 
6. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`. This will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/theysaidso. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Theysaidsocliproject’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/theysaidso/blob/master/CODE_OF_CONDUCT.md).


