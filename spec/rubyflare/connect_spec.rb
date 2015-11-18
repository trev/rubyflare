describe Rubyflare::Connect do

  let(:email)   { ENV['CLOUDFLARE_EMAIL'] }
  let(:api_key) { ENV['CLOUDFLARE_API_KEY'] }

  subject(:connection) { described_class.new(email, api_key) }

  describe '#initialize' do

    it 'stores the supplied email and api_key as instance variables' do
      expect(connection.instance_variable_get(:@email)).to eq email
      expect(connection.instance_variable_get(:@api_key)).to eq api_key
    end

    it "returns an instance of #{described_class}" do
      expect(connection).to be_a described_class
    end
  end

  describe '#get' do

    context 'with valid credentials' do

      context 'and a valid endpoint' do
        it 'returns an intance of Rubyflare::Response' do
          expect(connection.get('user')).to be_a Rubyflare::Response
        end
      end

      context 'and an invalid endpoint' do
        it 'raises a Rubyflare::ConnectionError' do
          expect { connection.get('invalid') }.to raise_error(Rubyflare::ConnectionError)
        end
      end
    end
    
    context 'with invalid credentials' do
      let(:email)   { 'bear@dog.com' }
      let(:api_key) { 'superapikey' }

      it 'raises a Rubyflare::ConnectionError' do
        expect { connection.get('user') }.to raise_error(Rubyflare::ConnectionError)
      end
    end
  end
end
