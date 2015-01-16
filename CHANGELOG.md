# CHANGELOG

This file is a manually maintained list of changes for each release. Feel free to add your
changes here when sending pull requests. Also send corrections if you spot any mistakes.

##
* Bug fix: Missing 'event_tickets' namespace for from client
* Feature: Implemented custom push message in the PassResource#push via :push_message attribute
```ruby
# @pass is a PassResource instance that maps to a pass in the system
@pass.push({push_message: "hello world"})
```


## v0.0.2 (2014-10-31)
* Bug fix: Fixed typo in the code that prevent creating an Asset

## v0.0.1 (2014-10-30)
* Initial release
