# ecsort

It's a lightweight tool that sorts environments and secrets used in Amazon ECS Task Definitions by name.

## Installation

```
gem install ecsort
```

## Usage

```
Usage: ecsort [--recursive, -r] [target]
  --recursive, -r
        Also process files in subdirectories. By default, only the given directroy (or current directroy) is processed.
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/shmokmt/ecsort.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
