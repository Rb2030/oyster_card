 require 'oystercard'

describe Oystercard do
  subject(:card) { described_class.new }

  let(:station){ double :station }


   it 'deducts an amount from the balance' do
     card.top_up(20)
     expect{ card.deduct 4 }.to change{card.balance}.by -4
   end

  describe '#balance' do
    it "oystercard understands the balance method" do
      expect(card).to respond_to(:balance)
    end
    it 'checks the balance' do
      expect(card.balance).to eq 0
    end
    it 'changes after topping up' do
      card.top_up(1)
      expect(card.balance).to eq 1
    end
    it 'has a maximum balance of 90' do
      expect(card.top_up(90)).to eq card.balance
    end
    it 'is initially not in a journey' do
      expect(card).not_to be_in_journey
    end

  end

  describe '#top_up' do
    it "tops the card up" do
      expect(card.top_up(1)).to eq card.balance
    end
    it 'adds money to a card with money already on it' do
      card.top_up(1)
      expect(card.top_up(3)).to eq 4
    end
     it 'raises error when exceeding maximum limit' do
      expect{card.top_up(91)}.to raise_error "Cannot top up more than 90"
    end
  end

  describe '#touch_in' do

    context 'when balance is above minimum' do
    before do
      card.top_up(20)
    end
    it 'It can touch in' do
      expect(card).to respond_to(:touch_in)
    end

    it 'It can touch into a station' do
      card.touch_in(station)
      expect(card.touch_in(station)).to eq true
    end
    it 'stores the entry station' do
      card.touch_in(station)
      expect(card.touch_in(station)). to eq true
      #expect(card.entry_station).to eq station
    end
  end
    context 'when insufficient funds' do
      it 'will not touch in, if below minimum balance' do
      expect{card.touch_in(station)}.to raise_error 'Cannot touch in.'#expect{ card.touch_in }.to raise_error "Cannot touch in due to insufficient funds"
    end
  end
  end

  describe '#touch_out' do
    it 'the card has left a station' do
      expect(card).to respond_to(:touch_out)
    end
    it ' deducts payment from card.' do
    card.top_up(5)
    card.touch_in(station)
    expect{ card.touch_out }.to change{ card.balance }.by(-Oystercard::MINIMUM)
    end
  end

  describe '#in_journey' do
    it 'the card is on a journey' do
      expect(card).to respond_to(:in_journey?)
    end
  end
end
