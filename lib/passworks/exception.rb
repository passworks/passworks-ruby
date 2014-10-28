module Passworks
  class Exception < ::StandardError
  end
end
Dir[File.dirname(__FILE__) + "/exceptions/*.rb"].each { |file| require file }