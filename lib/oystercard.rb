class Oystercard
  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  MINIMUM_FARE = 1
  attr_reader :balance, :entry_station, :exit_station, :journey_list

  def initialize
    @balance = 0
    @entry_station = nil
    @exit_station = nil
    @journey_list = []
  end

  def top_up(amount)
    fail "Max. balance #{MAXIMUM_BALANCE} exceeded" if max_balance?(amount)
    @balance += amount
  end

  def touch_in(station)
    fail "card already in use" if in_journey?
    fail "balance too low" if min_balance?
    @entry_station = station
  end

  def touch_out(station)
    fail "card is not in use" unless in_journey?
    deduct(MINIMUM_FARE)
    @exit_station = station
    add_journey
  end

  private

  def add_journey
    journey_list << {entry: @entry_station, exit: @exit_station}
    finish_journey
  end

  def finish_journey
    @entry_station = nil
    @exit_station = nil
  end

  def deduct(amount)
    @balance -= amount
  end

  def max_balance?(amount)
    (@balance + amount) > MAXIMUM_BALANCE
  end

  def min_balance?
    @balance < MINIMUM_BALANCE
  end

  def in_journey?
    @entry_station
  end
  
end
