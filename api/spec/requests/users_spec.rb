require 'rails_helper'

RSpec.describe 'User Authorization', type: :request do
  let(:base_url) { 'http://localhost:3000/api/auth/' }

  describe 'sign_up' do
    before {post base_url, params: params }

    context '正常' do
      let(:user) { create(:user) }
      let(:params) { { name: 'test', email: 'test@sample.com', password: 'password', password_confirmation: 'password' } }

      it 'ユーザーが新規登録できていること' do
        expect(user).to be_present
      end
      it 'HTTPステータスが200であること' do
        expect(response).to have_http_status(200)
      end
    end

    context '異常' do
      let(:params) { { name: 'test', email: 'test@sample.com' } }

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

  describe 'sign_out' do
    let!(:user) { create(:user) }
    let(:tokens) { sign_in(params) }
    let(:params) { { email: user[:email], password: 'password'} }
    #sign_inしている状態を作る
    before { post base_url + 'sign_in', params: params }

    context '正常' do
      it 'ユーザーがログアウト出来ること' do
        delete base_url + 'sign_out', headers: tokens
        expect(JSON.parse(response.body)['success']).to eq(true)
      end
      it 'HTTPステータスが200であること' do
        expect(response).to have_http_status(200)
      end
    end

    context '異常' do
      before { delete base_url + 'sign_out', headers: nil }
      it 'ユーザーがログアウト出来ないこと' do
        expect(JSON.parse(response.body)['errors']).to eq(["User was not found or was not logged in."])
      end
      it 'HTTPステータスが404である(ページが見つからない)こと' do
        expect(response).to have_http_status(404)
      end
    end
  end

  describe 'edit user' do
    let!(:user) { create(:user) }
    let(:tokens) { sign_in(params) }
    let(:params) { { email: user[:email], password: 'password'} }
    let(:new_name) { { name: 'new_test' } }
    before { post base_url + 'sign_in', params: params }

    context '正常' do
      it 'ユーザーの名前を変更できること' do

        put base_url, params: new_name, headers: tokens
        expect(JSON.parse(response.body)).to eq('lk')
      end
      it 'ユーザーのメールアドレスを変更できること'
    end

    xcontext '異常' do

    end
  end

  xdescribe 'change password' do
    context '正常' do

    end

    context '異常' do

    end
  end
end
