require 'rails_helper'

RSpec.describe 'Holdings', type: :request do
  let(:name) { 'yk' }
  let(:email) { 'yk@test.com' }
  let(:sign_up_params) {{
    name: name,
    email: email,
    password: 'password',
    password_confirmation: 'password',
  }}
  let(:base_url) { 'http://localhost:3000/api/auth/' }

  describe 'sign_up機能' do
    it '新規登録できていること' do
      post 'http://localhost:3000/api/auth/', params: sign_up_params
      expect(JSON.parse(response.body)['data']['email']).to eq(email)
    end

    it 'HTTPステータスが200であること' do
      post 'http://localhost:3000/api/auth/', params: sign_up_params
      expect(response).to have_http_status(200)
    end

    it '新規登録できないこと'
    it 'HTTPステータスが　であること'
  end

  describe 'sign_in機能' do
    let(:sign_in_params) { { email: email, password: 'password'} }
    let(:auth_tokens) { sign_in(sign_in_params) }
    before do
      post 'http://localhost:3000/api/auth/', params: sign_up_params
    end
    it 'HTTPステータスが200であること' do
      post '/api/auth/sign_in', params: sign_in_params
      expect(response).to have_http_status(200)
    end
    it 'ログイン出来ること' do
      post '/api/auth/sign_in', params: sign_in_params
      expect(JSON.parse(response.body)['data']['email']).to eq(email)
    end
    it 'Headerにトークン情報が付与されていること' do
      tokens = sign_in(sign_in_params)
      expect(response.headers['access-token']).to eq(tokens['access-token'])
    end
    it 'ログイン出来ないこと'
    it 'HTTPステータスが　であること'
  end

  describe 'sign_out機能' do
    it 'ログアウト出来ること'
    it ''
  end
end
