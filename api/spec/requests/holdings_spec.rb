require 'rails_helper'
require 'net/http'

#保有株一覧のJSON出力のテスト
RSpec.describe 'Holdings API', type: :request do
  let(:base_url) { 'http://localhost:3000/api/users/' }
  let!(:user) { create(:user) }
  let!(:stock) { create(:stock) }
  let!(:holding) { 3.times{create(:holding, user_id: user[:id], stock_id: stock[:id]) }}
  let(:tokens) { sign_in(params) }
  let(:params) { { email: user[:email], password: 'password' } }
  #事前にログインしておく
  before { post 'http://localhost:3000/api/auth', params: params }

  describe '#index Action' do
    context '正常' do
      context 'ユーザーAがユーザーAの保有株一覧を取得しようとした場合' do
        before { get base_url + user[:id].to_s + '/holdings', headers: tokens }

        it 'ログインしたユーザーの持っている保有株一覧が取得できること' do
          expect(JSON.parse(response.body)[0]['user']['name']).to eq(user[:name])
        end
        it 'HTTPステータスが200であること' do
          expect(response).to have_http_status(200)
        end
      end

      context 'ユーザーAがユーザーBの保有株一覧を取得しようとした場合' do
        let(:another_user) { create(:user) }
        before { get base_url + another_user[:id].to_s + '/holdings' }

        it '保有株一覧が取得できないこと' do
          expect(JSON.parse(response.body)['errors']).to eq(["You need to sign in or sign up before continuing."])
        end
        it 'HTTPステータスが401である(アクセス権がない)こと' do
          expect(response).to have_http_status(401)
        end
      end
    end

    context '異常' do
      context 'token情報がヘッダーに無い場合' do
        before { get base_url + user[:id].to_s + '/holdings' }
        it '保有株一覧が取得できないこと' do
          expect(JSON.parse(response.body)['errors']).to eq(["You need to sign in or sign up before continuing."])
        end
        it 'HTTPステータスが401である(アクセス権がない)こと' do
          expect(response).to have_http_status(401)
        end
      end



    end
  end
  # it 'index' do
  #   get base_url + user[:id].to_s + '/holdings', headers: tokens
  #   expect(user.holdings).to eq(holding)
  # end
  # it 'index' do
  #   get base_url + user[:id].to_s + '/holdings', headers: tokens
  #   expect(response.status).to eq('')
  # end
end
