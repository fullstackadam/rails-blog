require 'test_helper'

class SignupTest < ActionDispatch::IntegrationTest
  test 'invalid email results in failure' do
    get signup_path
    assert_template 'users/new'

    assert_no_difference 'User.count' do
      post users_path user: { username: 'adam', email: 'fghfhgfhf' , password: '1234' }
    end

    assert_template 'users/new'
  end

  test 'user account is created on signup' do
    get signup_path
    assert_template 'users/new'

    assert_difference 'User.count', 1 do
      post users_path user: { username: 'adam', email: 'mad@gmail.com' , password: '1234' }
    end
  end

  test 'user is signed in on signup' do
    get signup_path
    assert_template 'users/new'

    post users_path user: { username: 'adam', email: 'mad@gmail.com' , password: '1234' }

    assert session[:user_id]
  end
end