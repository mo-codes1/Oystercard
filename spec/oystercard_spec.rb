require './lib/oystercard'

describe Oystercard do
  let(:oystercard) { Oystercard.new }
  let(:station) { double:station }
  describe "#balance" do
    it 'expects there to be a balance on the card' do
      expect(oystercard.balance).to eq(0)
    end
  end

  describe "#top_up" do
    it { is_expected.to respond_to(:top_up).with(1).argument }
    it 'expects to be able to add money to a card' do
      expect { oystercard.top_up 10 }.to change { oystercard.balance }.by(10)
      expect { oystercard.top_up 20 }.to change { oystercard.balance }.by(20)
    end
    it 'expects to raise an error if balance exceeds 90' do
      maximum_balance = Oystercard::MAXIMUM_BALANCE
      oystercard.top_up(maximum_balance)
      expect { oystercard.top_up 1 }.to raise_error "Max. balance #{maximum_balance} exceeded"
    end
  end

  describe '#touch in' do
    it { is_expected.to respond_to(:touch_in).with(1).argument }
    it 'raises error when card already in use' do
      oystercard.top_up(2)
      oystercard.touch_in(station)
      expect { oystercard.touch_in(station) }.to raise_error 'card already in use'
    end
    it 'raises error when card is not over minimum balance' do
        minimum_balance = Oystercard::MINIMUM_BALANCE
        oystercard.top_up(minimum_balance - 1)
        expect { oystercard.touch_in(station) }.to raise_error 'balance too low'
    end
    it 'records the current station' do
      oystercard.top_up(2)
      oystercard.touch_in(station)
      expect(oystercard.entry_station).to eq station
    end
  end

  describe '#touch out' do
    it { is_expected.to respond_to(:touch_out).with(1).argument }
    it 'raises error when card is not in use' do
      expect { oystercard.touch_out(station) }.to raise_error 'card is not in use'
    end
    it 'deduces balance by minimum fare' do
      oystercard.top_up(Oystercard::MAXIMUM_BALANCE)
      oystercard.touch_in(station)
      expect { oystercard.touch_out(station)  }.to change { oystercard.balance }.by(-Oystercard::MINIMUM_FARE)
    end
    it 'removes recorded station' do
      oystercard.top_up(2)
      oystercard.touch_in(station)
      oystercard.touch_out(station)
      expect(oystercard.entry_station).to eq nil
    end
    it 'records the exit station' do
      oystercard.top_up(2)
      oystercard.touch_in(station)
      oystercard.touch_out(station)
      expect(oystercard.exit_station).to eq nil
    end
  end
    it 'expects an empty list of journeys by default' do
      expect(oystercard.journey_list).to be_empty
    end

    it 'adds journeys to list of journeys' do
      oystercard.top_up(2)
      oystercard.touch_in(station)
      expect { oystercard.touch_out(station) }.to change{oystercard.journey_list.length}.by 1
    end



  
end
