describe Rubyflare do

  describe '.connect_with_token' do
    subject(:connection) { described_class.connect_with_token('token') }

    it 'creates an instance of RubyFlare::Connect with passed arguments' do
      expect(Rubyflare::Connect).to receive(:new).with(api_token: 'token')
      connection
    end    
  end

  describe '.connect_with' do
    subject(:connection) { described_class.connect_with('bear@dog.com', 'superapikey') }

    it 'creates an instance of RubyFlare::Connect with passed arguments' do
      expect(Rubyflare::Connect).to receive(:new).with(email: 'bear@dog.com', api_key: 'superapikey')
      connection
    end

    it 'returns an instance of Rubyflare::Connect' do
      expect(connection).to be_a(Rubyflare::Connect)
    end
  end
end
