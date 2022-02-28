class Oystercard
  DEFAULT_BALANCE = 0
  MAX_BALANCE = 90

  attr_reader :balance

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
  end

  def top_up(money)
    fail 'Maximum limit reached' if over_limit?(money)

    @balance += money
  end

  private

  def over_limit?(money)
    @balance + money > MAX_BALANCE
  end

end
