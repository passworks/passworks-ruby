# CHANGELOG

This file is a manually maintained list of changes for each release. Feel free to add your
changes here when sending pull requests. Also send corrections if you spot any mistakes.

## v2.1.0 (2016-06-30)
* Features:
  - Added methods to retrieve campaign reports

## v2.0.7 (2016-01-05)
* Now able to delete assets and templates.

## v2.0.6 (2015-12-22)
* Fixed JSON errors when displaying attributes with a single error (non-array-format).

## v2.0.5 (2015-12-21)
* Fixed file upload issue cause by sending the wrong content-type.

## v2.0.4 (2015-12-18)
* Better exception and error handling

## v2.0.3 (2015-12-09)
* Added campaign resource's merge call, for propagating campaign pass data changes
  to all of it's passes.

## v2.0.2 (2015-12-01)
* Fixing collection_uuid on PassResource

## v2.0.1 (2015-11-27)
* Updated gemspec information

## v2.0.0 (2015-11-27)
* Updated SDK for version 2 of the API

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
