class CargoTrain < Train
  attr_reader :type

  def type
    @type = "cargo"
  end
end