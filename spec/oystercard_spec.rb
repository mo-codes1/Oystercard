require './lib/oystercard'

describe Oystercard do
  let(:oystercard) { Oystercard.new }
  it "expects there to be a balance on the card" do
    expect(oystercard.balance).to eq(0)
  end

end
