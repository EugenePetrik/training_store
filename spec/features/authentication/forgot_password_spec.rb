RSpec.describe 'ResetPassword' do
  let(:forgot_pass_page) { ForgotPasswordPage.new }
  let(:sign_in_page) { SignInPage.new }
  let(:user) { create(:user) }
  let(:success_message) { I18n.t('devise.passwords.send_instructions') }
  let(:error_message) { I18n.t('simple_form.error_notification.default_message') }
  let(:error_email_blank) { "Email can't be blank" }
  let(:error_email_not_found) { 'Email not found' }

  before { forgot_pass_page.load }

  context 'when open page' do
    it { expect(forgot_pass_page).to be_displayed }
    it { expect(forgot_pass_page).to be_all_there }
    it { expect(forgot_pass_page.title).to eq('Bookstore') }
  end

  context 'with correct email' do
    it 'user receives email' do
      forgot_pass_page.reset_password_with(user.email)

      expect(sign_in_page).to be_displayed
      expect(sign_in_page.success_flash.text).to eq(success_message)
    end
  end

  context 'with email in uppercase' do
    it 'user receives email' do
      forgot_pass_page.reset_password_with(user.email.upcase)

      expect(sign_in_page).to be_displayed
      expect(sign_in_page.success_flash.text).to eq(success_message)
    end
  end

  context 'with spaces before email' do
    it 'user receives email' do
      email = "   #{user.email.upcase}   "

      forgot_pass_page.reset_password_with(email)

      expect(sign_in_page).to be_displayed
      expect(sign_in_page.success_flash.text).to eq(success_message)
    end
  end

  context 'with empty email' do
    it 'raises an error' do
      forgot_pass_page.reset_password_with('')

      expect(forgot_pass_page.current_url).to end_with('/users/password')
      expect(forgot_pass_page.error_flash.text).to eq(error_message)
      expect(forgot_pass_page.email_error.text).to eq(error_email_blank)
    end
  end

  context 'with invalid email format' do
    it 'raises an error' do
      forgot_pass_page.reset_password_with('testexample.com')

      expect(forgot_pass_page.current_url).to end_with('/users/password')
      expect(forgot_pass_page.error_flash.text).to eq(error_message)
      expect(forgot_pass_page.email_error.text).to eq(error_email_not_found)
    end
  end

  context 'with nonexistent email' do
    it 'raises an error' do
      email = "user_#{user.email.upcase}"

      forgot_pass_page.reset_password_with(email)

      expect(forgot_pass_page.current_url).to end_with('/users/password')
      expect(forgot_pass_page.error_flash.text).to eq(error_message)
      expect(forgot_pass_page.email_error.text).to eq(error_email_not_found)
    end
  end
end
