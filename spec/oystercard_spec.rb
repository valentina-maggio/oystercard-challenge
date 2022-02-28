require 'oystercard'

describe Oystercard do 
  it 'has an initial balance of 0' do
    expect(subject.balance).to be_zero
  end
end
