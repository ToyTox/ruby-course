class ValidatorError < StandardError; end

module Validator
  def valid?
    validate!
    true
  rescue ValidationError
    false
  end
end