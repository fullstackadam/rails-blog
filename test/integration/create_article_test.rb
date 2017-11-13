require 'test_helper'

class CreateArticleTest < ActionDispatch::IntegrationTest
  def setup
    @password = 'password'

    @user = User.create(
      username: 'adam',
      email: 'adam@gmail.com',
      password: @password,
      admin: true
    )
  end

  test 'unauthenticated users cannot create articles' do
    get new_article_path
    assert_redirected_to root_path
  end

  test 'invalid article title results in failure' do
    sign_in_as(@user, @password)
    assert_no_difference 'Article.count' do
      post articles_path, article: { title: '' * 100, description: 'gjgadjshagjdafgsjhfdjhsafhjgjhf' }
      post articles_path, article: { title: 'g', description: 'hghjfhjafdjhfadhjgafahjdfghjafd' }
      post articles_path, article: { title: 'g' * 100, description: 'gjgadjshagjdafgsjhfdjhsafhjgjhf' }
    end
  end

  test 'invalid article description results in failure' do
    sign_in_as(@user, @password)
    assert_no_difference 'Article.count' do
      post articles_path, article: { title: 'gggg', description: 'h' * 4 }
      post articles_path, article: { title: 'ggggg', description: 'h' * 301 }
      post articles_path, article: { title: 'ggggg', description: '' }
    end
  end

  test 'article is created' do
    sign_in_as(@user, @password)

    assert_difference 'Article.count', 2 do
      post articles_path, article: { title: 'gggg', description: 'h' * 12 }
      post articles_path, article: { title: 'ggggg', description: 'h' * 250 }
    end
  end
end