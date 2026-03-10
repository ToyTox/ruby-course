class Wagon
  include CompanyName
  include Validator
  
  attr_reader :type

  def initialize(type)
    @type = type
    valid?
    # validate!
  end

  protected

  def validate!
    raise ValidatorError, "Тип вагона не может быть nil" if type.nil?
    raise ValidatorError, "Тип вагона должен быть :passanger или :cargo" unless %i[passenger cargo].include?(type)
    true
  end
end