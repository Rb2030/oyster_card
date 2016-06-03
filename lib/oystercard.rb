class Oystercard
  attr_reader :balance, :entry_station

MAXIMUM = 90
MINIMUM = 1

  def initialize
    @balance = 0
    @in_journey = false
    @entry_station = nil
  end

  def top_up(money)
    fail "Cannot top up more than 90" if balance + money > MAXIMUM
      @balance += money
  end

  def touch_in(station)
    raise 'Cannot touch in.' if balance < MINIMUM
    @entry_station = entry_station
    @in_journey = true
  end

  def touch_out
    deduct(MINIMUM)
    @in_journey = true
    @in_journey = false
  end

  def in_journey?
    false
  end

  def deduct(fare)
    @balance -= fare
  end

end



# card = Oystercard.new
# card.balance => nil
