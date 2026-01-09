class CargoWagon < Wagon
  attr_reader :type

  def type
    @type = "cargo"
  end
end