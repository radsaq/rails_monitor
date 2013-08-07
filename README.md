# RailsMonitor

This gem allows a rails application developer to simply and easily create an
application status page with a set of app checks that can double as monitoring
endpoints for nagios or other systems.

This gem has been developed with the generous support of [LightCastle Technical
Consulting](http://www.lightcastletech.com/).

## Installation

Add this line to your application's Gemfile:

    gem 'rails_monitor'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rails_monitor

## Usage

Include the monitoring mixin in your controller:

    include RailsMonitor::Monitoring

Define one or more tabs of status checks:

    status_tab :database, [:mysql_is_connected]

Define the accompanying endpoints:

    boolean_status :mysql_is_connected do
      true
    end

If your application is using jquery and bootstrap, this is all you should need
to do.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
