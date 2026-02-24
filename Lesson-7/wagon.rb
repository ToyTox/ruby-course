class Wagon
  include CompanyName
  include Validator
  
  attr_reader :type

  def initialize(type)
    @type = type
    validate!
    valid?
  end

  protected

  def validate!
    raise "Тип вагона не может быть nil" if type.nil?
    raise "Тип вагона должен быть :passanger или :cargo" unless %i[passenger cargo].include?(type)
    true
  end
end