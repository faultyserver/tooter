# Tooter
A Twitter-like social platform. Toot, favorite, follow, and @mention all around.

# Production

The production version of the application is running at http://faultytooter.herokuapp.com. Feel free to use it. If you find a bug, please [create an issue for it](https://github.com/faultyserver/tooter/issues/new), or [submit a pull request with a fix](https://github.com/faultyserver/tooter/issues/pull/new).

# Running Locally

Running a local version of Tooter (in `development`) is relatively simple. The application requires Ruby 2.3.1 and Rails 5 (both of which are specified in the Gemfile).

Once you have a local copy of the source code, just bundle the dependencies, load the database schema (running SQLite for development), and run the server:

```
bundle
rake db:schema:load
rails s
```

Tooter also has a fairly-complete test suite (sans a few of the newest features; mentions, etc.). It can be run by simply running RSpec at the application's root

```
rspec
```

Currently, one test is known to fail for reasons that are unknown. `sessions[:user_id]` is returning nil when it should be 1. However, the functionality is working even for other tests in the same file, which is rather confusing.
