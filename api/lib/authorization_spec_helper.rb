module AuthorizationSpecHelper
  def sign_up(user)
    post "/auth/sign_up",
      params: { email: user[:email], password: user[:password] },
      as: :json

    response.headers.slice('client', 'access-token', 'uid')
  end
end