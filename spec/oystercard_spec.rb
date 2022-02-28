require 'oystercard'

describe Oystercard do 
  it 'has an initial balance of 0' do
    expect(subject.balance).to be_zero
  end

  it 'responds to top up method' do
    expect(subject).to respond_to(:top_up)
  end

  it 'tops up the balance' do
    expect { subject.top_up(20) }.to change { subject.balance }.by(20)
  end

  it 'stops you topping up over £90' do
    too_much = Oystercard::MAX_BALANCE + 1
    expect { subject.top_up(too_much) }.to raise_error 'Maximum limit reached'
  end
  
end
