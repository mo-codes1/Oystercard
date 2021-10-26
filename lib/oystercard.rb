class Oystercard
  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  attr_reader :balance, :amount, :entry_station

  def initialize
    @balance = 0
    @entry_station = nil
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

  def touch_out(fare = 1)
    fail "card is not in use" unless in_journey?
    deduct(fare)
    @entry_station = nil
  end

  private

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
