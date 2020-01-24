RSpec.describe 'SignIn' do
  let(:sign_in_page) { SignInPage.new }
  let(:home_page) { HomePage.new }

  let(:user) { create(:user) }

  let(:params_login_data) do
    {
      email: user.email,
      password: user.password
    }
  end

  let(:success_message) { 'Signed in successfully.' }
  let(:error_message) { 'Invalid Email or password.' }

  before { sign_in_page.load }

  context 'when open page', :smoke do
    it { expect(sign_in_page).to be_displayed }
    it { expect(sign_in_page).to be_all_there }
    it { expect(sign_in_page.title).to eq('Bookstore') }
  end

  context 'with correct email and password' do
    it 'user logs in' do
      sign_in_page.login_with(params_login_data)

      expect(home_page).to be_displayed
      expect(home_page.success_flash.text).to eq(success_message)
    end
  end

  context 'with email in uppercase' do
    it 'user logs in' do
      params_login_data[:email] = user.email.upcase

      sign_in_page.login_with(params_login_data)

      expect(home_page).to be_displayed
      expect(home_page.success_flash.text).to eq(success_message)
    end
  end

  context 'with nonexistent email' do
    it 'raises an error' do
      params_login_data[:email] = "user_#{user.email.upcase}"

      sign_in_page.login_with(params_login_data)

      expect(sign_in_page.error_flash.text).to eq(error_message)
    end
  end

  context 'with invalid email format' do
    it 'raises an error' do
      params_login_data[:email] = 'testexample.com'

      sign_in_page.login_with(params_login_data)

      expect(sign_in_page.error_flash.text).to eq(error_message)
    end
  end

  context 'with empty email' do
    it 'raises an error' do
      params_login_data[:email] = ' '

      sign_in_page.login_with(params_login_data)

      expect(sign_in_page.error_flash.text).to eq(error_message)
    end
  end

  context 'with incorrect password' do
    it 'raises an error' do
      params_login_data[:password] = "pass_#{user.password}"

      sign_in_page.login_with(params_login_data)

      expect(sign_in_page.error_flash.text).to eq(error_message)
    end
  end

  context 'with empty password' do
    it 'raises an error' do
      params_login_data[:password] = ' '

      sign_in_page.login_with(params_login_data)

      expect(sign_in_page.error_flash.text).to eq(error_message)
    end
  end

  context 'with empty email and password' do
    it 'raises an error' do
      params_login_data[:email] = ''
      params_login_data[:password] = ''

      sign_in_page.login_with(params_login_data)

      expect(sign_in_page.error_flash.text).to eq(error_message)
    end
  end
end
