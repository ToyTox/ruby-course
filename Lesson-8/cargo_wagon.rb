# frozen_string_literal: true

class CargoWagon < Wagon
  attr_reader :volume, :total_taken_volume

  def initialize(volume)
    super(:cargo)
    @volume = volume
    @total_taken_volume = 0
  end

  def take_volume(count)
    return if (@total_taken_volume + count) > @volume

    @total_taken_volume += count
  end

  def remaining_volume
    @volume - @total_taken_volume
  end
end
