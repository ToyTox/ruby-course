class PassengerWagon < Wagon
  attr_reader seat_count

  def initialize(seat_count)
    super(:passenger)
    @seat_count = seat_count
    @seats = []
    @reserved_seat = 1
  end

  def reservation_seat
    return if @seats.size > @seat_count

    seats << @reserved_seat
    sefl.reserved_seat += 1
  end

  def show_reserved_seat
    @seats
  end

  def show_free_seat
    @seat_count - (@seats.size + 1)
  end
end