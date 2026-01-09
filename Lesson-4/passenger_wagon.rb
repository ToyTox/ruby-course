class PassengerWagon < Wagon
  attr_reader :type

  def type
    @type = "passenger"
  end
end