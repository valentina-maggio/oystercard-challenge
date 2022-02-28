require 'oystercard'

describe Oystercard do 
  it 'has an initial balance of 0' do
    expect(subject.balance).to be_zero
  end

  it 'responds to top up method' do
    expect(subject).to respond_to(:top_up)
  end

  it 'tops up the balance' do
    # when you add 20 to the balance it returns 20 (the balance)
    expect { subject.top_up(20) }.to change { subject.balance }.by(20)
  end 
end
