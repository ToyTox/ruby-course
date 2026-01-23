class PassengerWagon < Wagon
  def initialize
    super(:passenger)
  end

  def type
    :passenger
  end
end