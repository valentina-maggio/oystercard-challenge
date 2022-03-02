require 'journey'

describe Journey do
  subject(:journey) { described_class.new }
  # calculating fare
  # journey complete?
  
  # starting a journey
  it 'starts the journey' do
    expect { journey.start_journey('Waterloo') }.not_to raise_error
  end
  
  # finishing a journey
  it 'finishes the journey' do
    expect { journey.end_journey('Sloane Square') }.not_to raise_error
  end

  describe '#journey_record' do
    it 'returns the journey hash' do
      journey.start_journey('Waterloo')
      journey.end_journey('Sloane Square')
      expect(journey.journey_record).to include(
        entry: 'Waterloo',
        exit: 'Sloane Square'
     )
    end
  end

  context 'checks if the journey is complete' do
    it 'returns false when incomplete' do
      journey.start_journey('Waterloo')
      expect(journey.complete?).to be false
    end
  end
end
