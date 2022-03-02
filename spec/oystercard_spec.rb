require 'oystercard'

describe Oystercard do
  subject(:card) { described_class.new }
  
  let(:station) { double(:station_double) }
  
  before do
    allow(station).to receive(:name).and_return('Euston') 
  end

  it 'has an initial balance of 0' do
    expect(card.balance).to be_zero
  end

  it 'has a default entry station of nil' do
    expect(card.entry_station).to be_nil
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
  
  describe '#touch_in' do
    it 'raises an error if insufficient funds' do
      expect { card.touch_in(station.name) }.to raise_error 'Insufficient Funds'
    end

    it 'changes the entry station' do
      card.top_up(Oystercard::MIN_FARE + 1)
      expect { card.touch_in(station.name) }.to change { card.entry_station }.from(nil).to(station.name)
    end
  end

  describe '#touch_out' do
    before do
      card.top_up(Oystercard::MIN_FARE + 1)
      card.touch_in(station.name)
    end

    it 'takes one argument' do
      expect(card).to respond_to(:touch_out).with(1).argument
    end

    it 'deducts the minimum fare when touching out' do
      expect { card.touch_out(station.name) }.to change { card.balance }.by(-Oystercard::MIN_FARE)
    end

    it 'resets the entry station' do
      expect { card.touch_out(station.name) }.to change { card.entry_station }.from(station.name).to(nil)
    end
  end
end
