require './lib/oystercard'

describe Oystercard do
  let(:oystercard) { Oystercard.new }
  it 'expects there to be a balance on the card' do
    expect(oystercard.balance).to eq(0)
  end

  it { is_expected.to respond_to(:top_up).with(1).argument }

  it 'expects to be able to add money to a card' do
    expect { oystercard.top_up 10 }.to change { oystercard.balance }.by(10)
  end
end
