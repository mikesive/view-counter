# View Counter

View Counter is a command line tool that counts the total number of views, and number of unique views in a given log file.

## Usage

An executable is available at `/bin/view_counter.rb`, which can be run as follow:

```
./bin/view_counter.rb /path/to/your/logfile
```

which will output something like:

```
## Total Page Views
/home                          78
/about                         70
/mypage                        3

## Total Unique Page Views
/home                          5
/about                         3
/mypage                        1
```

## Tests

View Counter uses RSpec for testing and SimpleCov for test coverage. If you would like to run the tests, please install the dependencies from the Gemfile using bundler:

```
bundle install
```

and then run:

```
bundle exec rspec
```

This will generate coverage files and test results under the artifacts directory.

Furthermore, this project is using Rubcop to enforce a style guide. You can run:

```
bundle exec rubocop
```

which will generate Rubocop results, also in the artifacts directory.
