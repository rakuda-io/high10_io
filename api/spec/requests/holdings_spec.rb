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

  #TestUserを最初に設定
  # let!(:user) { create(:user) }

  let(:base_url) { 'http://localhost:3000/api/auth/' }

  describe 'sign_up' do
    context '正常' do
      let(:user) { create(:user) }
      it 'ユーザーが新規登録できていること' do
        expect(user).to be_present
      end
      it 'HTTPステータスが200であること' do
        post base_url, params: { name: 'test', email: 'test@sample.com', password: 'password', password_confirmation: 'password'}
        expect(response).to have_http_status(200)
      end
    end

    context '異常' do
      before {post base_url, params: { name: 'test', email: 'test@sample.com' }}
      it 'ユーザーが新規登録できていないこと' do
        expect(JSON.parse(response.body)['errors']['full_messages']).to eq(["Password can't be blank"])
      end
      it 'HTTPステータスが422である(処理ができない)こと' do
        expect(response).to have_http_status(422)
      end
    end
  end

  describe 'sign_in' do
    before { post base_url + 'sign_in', params: params }
    context '正常' do
      let(:user) { create(:user) }
      let(:params) { { email: user[:email], password: 'password'} }
      it 'ログインしようとしたユーザーでログイン出来ていること' do
        expect(JSON.parse(response.body)['data']['email']).to eq(user[:email])
      end
      it 'HTTPステータスが200であること' do
        expect(response).to have_http_status(200)
      end
      it 'ヘッダーに正しいトークン情報が付与されていること' do
        tokens = sign_in(params)
        expect(response.headers['access-token']).to eq(tokens['access-token'])
      end
    end

    context '異常' do
      let(:user) { create(:user) }
      let(:params) { { email: user[:email] } }
      it 'ログイン出来ないこと' do
        expect(JSON.parse(response.body)['errors']).to eq(["Invalid login credentials. Please try again."])
      end
      it 'HTTPステータスが401である(アクセス権がない)こと' do
        expect(response).to have_http_status(401)
      end
    end
  end

  describe 'sign_out機能' do
    it 'ログアウト出来ること'
    it ''
  end
end
