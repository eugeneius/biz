# frozen_string_literal: true

RSpec.describe Biz::Calculation::OnBreak do
  subject(:calculation) {
    described_class.new(
      schedule(breaks: {Date.new(2006, 1, 4) => {'11:00' => '13:00'}}),
      time
    )
  }

  describe '#result' do
    context 'when the time is at the beginning of a break' do
      let(:time) { Time.utc(2006, 1, 4, 11) }

      it 'returns true' do
        expect(calculation.result).to eq true
      end
    end

    context 'when the time is in the middle of a break' do
      let(:time) { Time.utc(2006, 1, 4, 12) }

      it 'returns true' do
        expect(calculation.result).to eq true
      end
    end

    context 'when the time is at the end of a break' do
      let(:time) { Time.utc(2006, 1, 4, 13) }

      it 'returns false' do
        expect(calculation.result).to eq false
      end
    end

    context 'when the time is not during a break' do
      let(:time) { Time.utc(2006, 1, 5, 12) }

      it 'returns false' do
        expect(calculation.result).to eq false
      end
    end
  end
end
