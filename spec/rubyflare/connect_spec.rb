describe Rubyflare::Connect do

  subject { described_class.new(email, api_key) }

  describe '#initialize' do

    let(:email)   { ENV['CLOUDFLARE_EMAIL'] }
    let(:api_key) { ENV['CLOUDFLARE_API_KEY'] }

    it 'stores the supplied email and api_key as instance variables' do
      expect(subject.instance_variable_get(:@email)).to eq email
      expect(subject.instance_variable_get(:@api_key)).to eq api_key
    end

    context 'with valid credentials' do
      it 'sets success to true' do
        expect(subject.success).to be true
      end
    end

    context 'with invalid credentials' do
      let(:email)   { 'bear@dog.com' }
      let(:api_key) { 'supersecretapikey' }

      it 'sets success to false' do
        expect(subject.success).to be false
      end

      it 'sets error to Rubyflare::ConnectionError' do
        expect(subject.error).to be_a Rubyflare::ConnectionError
      end
    end

    it "returns a instance of #{described_class}" do
      expect(subject).to be_a described_class
    end
  end
end
