RSpec.describe 'SignUp' do
  let(:sign_up_page) { SignUpPage.new }
  let(:home_page) { HomePage.new }

  let(:email) { FFaker::Internet.email }
  let(:password) { FFaker::Internet.password }

  let(:params_signup_data) do
    {
      email: email,
      password: password,
      password_confirmation: password
    }
  end

  let(:success_message) { 'Welcome! You have signed up successfully.' }
  let(:error_email_blank_invalid) { "Email can't be blank and Email is invalid" }
  let(:error_email_invalid) { 'Email is invalid' }
  let(:error_email_taken) { 'Email has already been taken' }
  let(:error_pass_blank) { "Password can't be blank" }
  let(:error_pass_less_chars) { '6 characters minimum' }
  let(:error_pass_short) { 'Password is too short (minimum is 6 characters)' }
  let(:error_pass_confirm_match) { "Password confirmation doesn't match Password" }

  before { sign_up_page.load }

  context 'when open page' do
    it { expect(sign_up_page).to be_displayed }
    it { expect(sign_up_page).to be_all_there }
    it { expect(sign_up_page.title).to eq('Bookstore') }
  end

  context 'with valid data' do
    it 'user signs up' do
      sign_up_page.sign_up_with(params_signup_data)

      expect(home_page).to be_displayed
      expect(home_page.success_flash_text).to eq(success_message)
    end
  end

  context 'with existing email in the system' do
    let(:user) { create(:user) }

    it 'raises an error' do
      params_signup_data[:email] = user.email
      params_signup_data[:password] = user.password
      params_signup_data[:password_confirmation] = user.password

      sign_up_page.sign_up_with(params_signup_data)

      expect(sign_up_page).to be_displayed
      expect(sign_up_page.email_error_text).to eq(error_email_taken)
    end
  end

  context 'with empty data' do
    it 'raises an error' do
      params_signup_data[:email] = ''
      params_signup_data[:password] = ''
      params_signup_data[:password_confirmation] = ''

      sign_up_page.sign_up_with(params_signup_data)

      expect(sign_up_page).to be_displayed
      expect(sign_up_page.email_error_text).to eq(error_email_blank_invalid)
      expect(sign_up_page.pass_error_text).to eq(error_pass_blank)
      expect(sign_up_page.pass_less_6_chars_error_text).to eq(error_pass_less_chars)
    end
  end

  context 'with invalid email format' do
    it 'raises an error' do
      params_signup_data[:email] = 'testexample.com'

      sign_up_page.sign_up_with(params_signup_data)

      expect(sign_up_page).to be_displayed
      expect(sign_up_page.email_error_text).to eq(error_email_invalid)
    end
  end

  context 'with empty email' do
    it 'raises an error' do
      params_signup_data[:email] = ''

      sign_up_page.sign_up_with(params_signup_data)

      expect(sign_up_page).to be_displayed
      expect(sign_up_page.email_error_text).to eq(error_email_blank_invalid)
    end
  end

  context 'with empty password' do
    it 'raises an error' do
      params_signup_data[:password] = ''

      sign_up_page.sign_up_with(params_signup_data)

      expect(sign_up_page).to be_displayed
      expect(sign_up_page.pass_error_text).to eq(error_pass_blank)
      expect(sign_up_page.pass_less_6_chars_error_text).to eq(error_pass_less_chars)
      expect(sign_up_page.pass_confirm_error_text).to eq(error_pass_confirm_match)
    end
  end

  context 'with password less than 6 characters' do
    it 'raises an error' do
      params_signup_data[:password] = '12345'
      params_signup_data[:password_confirmation] = '12345'

      sign_up_page.sign_up_with(params_signup_data)

      expect(sign_up_page).to be_displayed
      expect(sign_up_page.pass_error_text).to eq(error_pass_short)
      expect(sign_up_page.pass_less_6_chars_error_text).to eq(error_pass_less_chars)
    end
  end

  context 'with empty password confimation' do
    it 'raises an error' do
      params_signup_data[:password_confirmation] = ''

      sign_up_page.sign_up_with(params_signup_data)

      expect(sign_up_page).to be_displayed
      expect(sign_up_page.pass_confirm_error_text).to eq(error_pass_confirm_match)
    end
  end

  context 'with different passwords' do
    it 'raises an error' do
      params_signup_data[:password] = "   #{password}   "
      params_signup_data[:password_confirmation] = password

      sign_up_page.sign_up_with(params_signup_data)

      expect(sign_up_page).to be_displayed
      expect(sign_up_page.pass_confirm_error_text).to eq(error_pass_confirm_match)
    end
  end
end
