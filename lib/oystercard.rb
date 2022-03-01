class Oystercard
  DEFAULT_BALANCE = 0
  MAX_BALANCE = 90
  MIN_BALANCE = 1

  attr_reader :balance

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    @in_journey = false
  end

  def top_up(money)
    fail 'Maximum limit reached' if over_limit?(money)

    @balance += money
  end

  def deduct(fare)
    @balance -= fare
  end

  def in_journey?
    @in_journey
  end

  def touch_in
    fail 'Insufficient Funds' if under_min_balance?

    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end

  private

  def over_limit?(money)
    @balance + money > MAX_BALANCE
  end

  def under_min_balance?
    @balance < MIN_BALANCE
  end
end
