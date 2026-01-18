class PassengerTrain < Train
  def initialize
    super(:passenger)
  end
  
  def type
    :passenger
  end
end