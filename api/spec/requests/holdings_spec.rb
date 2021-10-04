require 'rails_helper'

RSpec.describe 'Holdings', type: :request do
  let(:sign_up_params) {{
    name: 'yk',
    email: 'yk@sample.com',
    password: 'password',
    password_confirmation: 'password',
  }}

  describe "sign_up" do
    it '新規登録できていること' do
      post 'http://localhost:3000/api/auth/', params: sign_up_params
      expect(JSON.parse(response.body)['data']['email']).to eq('yk@sample.com')
    end

    it 'HTTPステータスが200であること' do
      post 'http://localhost:3000/api/auth/', params: sign_up_params
      expect(response).to have_http_status(200)
    end
  end
end
