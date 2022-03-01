require 'oystercard'

describe Oystercard do
  subject(:card) { described_class.new }

  it 'has an initial balance of 0' do
    expect(card.balance).to be_zero
  end
  
  describe '#top_up' do
    it 'responds to top up method' do
      expect(card).to respond_to(:top_up)
    end

    it 'tops up the balance' do
      expect { card.top_up(20) }.to change { card.balance }.by(20)
    end

    it 'stops you topping up over £90' do
      too_much = Oystercard::MAX_BALANCE + 1
      expect { card.top_up(too_much) }.to raise_error 'Maximum limit reached'
    end
  end
  
  describe '#in_journey?' do
    it 'responds to in_journey? method' do
      expect(card).to respond_to(:in_journey?)
    end

    it 'defaults to not on journey' do
      expect(card.in_journey?).to be false
    end
  end

  describe '#touch_in' do
    it 'starts a journey' do
      card.top_up(Oystercard::MIN_FARE + 1)
      expect { card.touch_in }.to change { card.in_journey? }.to be true 
    end

    it 'raises an error if insufficient funds' do
      expect { card.touch_in }.to raise_error 'Insufficient Funds'
    end
  end

  describe '#touch_out' do
    before do
      card.top_up(Oystercard::MIN_FARE + 1)
      card.touch_in
    end

    it 'ends a journey' do
      expect { card.touch_out }.to change { card.in_journey? }.to be false
    end

    it 'deducts the minimum fare when touching out' do
      expect { card.touch_out }.to change { card.balance }.by(-Oystercard::MIN_FARE)
    end
  end
end
