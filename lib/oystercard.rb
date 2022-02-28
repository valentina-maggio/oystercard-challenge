class Oystercard
  DEFAULT_BALANCE = 0
  MAX_BALANCE = 90

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

  private

  def over_limit?(money)
    @balance + money > MAX_BALANCE
  end

end
