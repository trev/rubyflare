describe 'integration' do
  describe Rubyflare, order: :defined do
    context 'given I have valid Cloudflare credentials' do
      let(:email)   { "foo@example.com" }
      let(:api_key) { "f3e0d662c670bcec36af2ff769748fca4c56c" }

      before do
        stub_request(:get, "https://api.cloudflare.com/client/v4/user").with(headers: {'X-Auth-Key': api_key}).
          to_return(status: 200, body: '{"success":true,"errors":[],"messages":[],"result":null}')
        stub_request(:patch, "https://api.cloudflare.com/client/v4/user").with(headers: {'X-Auth-Key': api_key}).
          to_return(status: 200, body: '{"success":true,"errors":[],"messages":[],"result":null}')
      end

      context 'when I create a Rubyflare instance' do
        let(:connection) { described_class.connect_with(email, api_key) }

        context 'and GET my Cloudflare user details' do

          it 'should return a valid response' do
            response = connection.get('user')
            expect(response).to be_successful
          end
        end

        context 'and update(PATCH) my user details' do

          it 'should return a valid response' do
            response = connection.patch('user', { first_name: 'Trevor' })
            expect(response).to be_successful
          end
        end
      end
    end
  end
end
