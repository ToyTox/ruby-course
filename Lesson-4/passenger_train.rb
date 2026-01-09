class PassengerTrain < Train
  attr_reader :type

  def type
    @type = "passenger"
  end
end