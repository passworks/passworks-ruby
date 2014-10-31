require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
  c.filter_sensitive_data('PASSWORKS_API_USERNAME'){ ENV['PASSWORKS_API_USERNAME'] }
  c.filter_sensitive_data('PASSWORKS_API_SECRET'){   ENV['PASSWORKS_API_SECRET']   }
end