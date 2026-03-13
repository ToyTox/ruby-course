class ValidatorError < StandardError; end

module Validator
  def valid?
    validate!
    true
  rescue ValidatorError
    false
  end
end