class PassengerWagon < Wagon
  attr_reader :seat_count

  def initialize(seat_count)
    super(:passenger)
    @seat_count = seat_count
    @taken_seats = 0
  end

  def reservation_seat
    return if @taken_seats >= @seat_count

    @taken_seats += 1
  end

  def taken_seats
    @taken_seats
  end

  def free_seats
    @seat_count - @taken_seats
  end
end