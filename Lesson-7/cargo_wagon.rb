class CargoWagon < Wagon
  attr_reader :volume

  def initialize(volume)
    super(:cargo)
    @volume = volume
    @total_taken_volume = 0
  end

  def take_volume(count)
    return if (@total_taken_volume + count) > @volume

    @total_taken_volume += count
  end

  def total_taken_volume
    @total_taken_volume
  end

  def remaining_volume
    @volume - @total_taken_volume
  end
end