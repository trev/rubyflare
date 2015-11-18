describe Rubyflare do

  describe '.connect' do
    it 'creates an instance of RubyFlare::Connect with passed arguments' do
      expect(Rubyflare::Connect).to receive(:new).with('bear@dog.com', 'superapikey')
      described_class.connect('bear@dog.com', 'superapikey')
    end

    it 'returns an instance of Rubyflare::Connect' do
      connection = described_class.connect('bear@dog.com', 'superapikey')
      expect(connection).to be_a(Rubyflare::Connect)
    end
  end
end
