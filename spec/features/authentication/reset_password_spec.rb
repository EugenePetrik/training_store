RSpec.describe 'ResetPassword' do
  let(:home_page) { HomePage.new }
  let(:forgot_pass_page) { ForgotPasswordPage.new }
  let(:reset_pass_page) { ResetPassword.new }
  let(:user) { create(:user) }
  let(:password) { FFaker::Internet.password }

  let(:params_reset_pass_data) do
    {
      password: password,
      password_confirmation: password
    }
  end

  let(:success_message) { I18n.t('devise.passwords.updated') }
  let(:error_message) { I18n.t('simple_form.error_notification.default_message') }
  let(:error_pass_blank) { "Password can't be blank" }
  let(:error_pass_short) { 'Password is too short (minimum is 6 characters)' }
  let(:error_pass_confirm_match) { "Password confirmation doesn't match Password" }

  before do
    clear_emails

    forgot_pass_page.load
    forgot_pass_page.reset_password_with(user.email)

    open_email(user.email)
    current_email.click_link('Change my password')
  end

  context 'when open page' do
    it { expect(reset_pass_page).to be_displayed }
    it { expect(reset_pass_page).to be_all_there }
    it { expect(reset_pass_page.title).to eq('Bookstore') }
  end

  context 'with correct data' do
    it 'user logs in' do
      reset_pass_page.change_pass_with(params_reset_pass_data)

      expect(home_page.success_flash.text).to eq(success_message)
      expect(home_page.user_email.text).to eq(user.email)
      expect(home_page).to have_no_sign_up_link
      expect(home_page).to have_no_login_link
    end
  end

  context 'with empty data' do
    it 'raises an error' do
      params_reset_pass_data[:password], params_reset_pass_data[:password_confirmation] = ''
      reset_pass_page.change_pass_with(params_reset_pass_data)

      expect(reset_pass_page.current_url).to end_with('/users/password')
      expect(reset_pass_page.error_flash.text).to eq(error_message)
      expect(reset_pass_page.pass_error.text).to eq(error_pass_blank)
    end
  end

  context 'with password less than 6 characters' do
    it 'raises an error' do
      params_reset_pass_data[:password], params_reset_pass_data[:password_confirmation] = rand(100_000)
      reset_pass_page.change_pass_with(params_reset_pass_data)

      expect(reset_pass_page.current_url).to end_with('/users/password')
      expect(reset_pass_page.error_flash.text).to eq(error_message)
      expect(reset_pass_page.pass_error.text).to eq(error_pass_short)
    end
  end

  context 'with empty password confimation' do
    it 'raises an error' do
      params_reset_pass_data[:password_confirmation] = ''
      reset_pass_page.change_pass_with(params_reset_pass_data)

      expect(reset_pass_page.current_url).to end_with('/users/password')
      expect(reset_pass_page.error_flash.text).to eq(error_message)
      expect(reset_pass_page.pass_confirm_error.text).to eq(error_pass_confirm_match)
    end
  end

  context 'with different passwords' do
    it 'raises an error' do
      params_reset_pass_data[:password] = "   #{password}   "
      params_reset_pass_data[:password_confirmation] = password
      reset_pass_page.change_pass_with(params_reset_pass_data)

      expect(reset_pass_page.current_url).to end_with('/users/password')
      expect(reset_pass_page.error_flash.text).to eq(error_message)
      expect(reset_pass_page.pass_confirm_error.text).to eq(error_pass_confirm_match)
    end
  end
end
