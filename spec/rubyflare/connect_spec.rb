describe Rubyflare::Connect do

  let(:email)   { "foo@example.com" }
  let(:api_key) { "f3e0d662c670bcec36af2ff769748fca4c56c" }
  let(:invalid_api_key) { "4e70c76fdda8544a80b544f9d4b738af5990d" }

  subject(:connection) { described_class.new(email: email, api_key: api_key) }

  before do
    stub_request(:get, "https://api.cloudflare.com/client/v4/user").with(headers: {'X-Auth-Key': api_key}).
      to_return(status: 200, body: '{"success":true,"errors":[],"messages":[],"result":null}')
    stub_request(:get, "https://api.cloudflare.com/client/v4/user").with(headers: {'X-Auth-Key': invalid_api_key}).
      to_return(status: 200, body: '{"success":false,"errors":[{"code":9103,"message":"Unknown X-Auth-Key or X-Auth-Email"}],"messages":[],"result":null}')
    stub_request(:get, "https://api.cloudflare.com/client/v4/invalid").
      to_return(status: 400, body: '{"success":false,"errors":[{"code":7000,"message":"No route for that URI"}],"messages":[],"result":null}')
  end

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
      let(:api_key) { invalid_api_key }

      it 'raises a Rubyflare::ConnectionError' do
        expect { connection.get('user') }.to raise_error(Rubyflare::ConnectionError)
      end
    end
  end
end
