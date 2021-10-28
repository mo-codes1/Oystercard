require './lib/station'

describe Station do
    subject(:station) { Station.new(name = "Euston", zone = 1)}

    it 'expects to take in zone' do
        expect(station).to respond_to(:zone)
    end
    it 'expects to take in name' do
        expect(station).to respond_to(:name)
    end
end

        