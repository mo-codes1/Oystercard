require './lib/oystercard'

describe Oystercard do
  let(:oystercard) { Oystercard.new }

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

  describe '#deduct' do
    it { is_expected.to respond_to(:deduct).with(1).argument }
    it 'expects an amount to be deducted from an oystercard' do
      oystercard.top_up(50)
      expect { oystercard.deduct 10 }.to change { oystercard.balance }.by(-10)
      expect { oystercard.deduct 20 }.to change { oystercard.balance }.by(-20)
    end
  end

  describe '#touch in' do
    
    it { is_expected.to respond_to(:touch_in) }
    it 'expects to be mark the card as in use' do
      oystercard.top_up(2)
      expect { oystercard.touch_in }.to change { oystercard.in_use }.to eq true 
    end
    it 'raises error when card already in use' do
      oystercard.top_up(2)
      oystercard.touch_in
      expect { oystercard.touch_in }.to raise_error 'card already in use'
    end
    it 'raises error when card is not over minimum balance' do
        minimum_balance = Oystercard::MINIMUM_BALANCE
        #oystercard.deduct(Oystercard::MAXIMUM_BALANCE)
        oystercard.top_up(minimum_balance - 1)
        expect { oystercard.touch_in }.to raise_error 'balance too low'
    end
  end

  describe '#touch out' do
    it { is_expected.to respond_to(:touch_out) }
    it 'expects to be mark the card as not in use' do
      oystercard.top_up(2)
      oystercard.touch_in
      expect { oystercard.touch_out }.to change { oystercard.in_use }.to eq false 
    end
    it 'raies error when card is not in use' do
      expect { oystercard.touch_out }.to raise_error 'card is not in use'
    end
  end

  
end
