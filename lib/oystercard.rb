class Oystercard
  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  attr_reader :balance, :amount, :in_use

  def initialize
    @balance = 0
    @in_use = false
  end

  def top_up(amount)
    fail "Max. balance #{MAXIMUM_BALANCE} exceeded" if max_balance?(amount)

    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def touch_in
    fail "card already in use" if in_journey?
    fail "balance too low" if min_balance?
    @in_use = true
  end

  def touch_out
    @in_use = false
  end

  private

  def max_balance?(amount)
    (@balance + amount) > MAXIMUM_BALANCE
  end

  def min_balance?
    @balance < MINIMUM_BALANCE
  end

  def in_journey?
    @in_use
  end
  
end
