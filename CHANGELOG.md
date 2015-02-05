# CHANGELOG

This file is a manually maintained list of changes for each release. Feel free to add your
changes here when sending pull requests. Also send corrections if you spot any mistakes.

## v0.0.5 (2015-01-23)
* Added possibility of listing certificates.

## v0.0.4 (2015-01-19)
* Bug fix: Pagination bug regression found when fetching resources with only one page

## v0.0.3 (2015-01-16)
* Bug fix: Missing 'event_tickets' namespace for from client
* Bug fix: Passworks::Response#ok? now returning correct information
* Feature: Implemented custom push message in the PassResource#push via :push_message attribute
```ruby
# @pass is a PassResource instance that maps to a pass in the system
@pass.push({push_message: "hello world"})
```


## v0.0.2 (2014-10-31)
* Bug fix: Fixed typo in the code that prevent creating an Asset

## v0.0.1 (2014-10-30)
* Initial release
