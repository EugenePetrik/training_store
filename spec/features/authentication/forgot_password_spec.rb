RSpec.describe 'ForgotPassword' do
  let(:forgot_pass_page) { ForgotPasswordPage.new }
  let(:sign_in_page) { SignInPage.new }

  let(:user) { create(:user) }

  let(:success_message) { 'You will receive an email with instructions on how to reset your password in a few minutes.' }

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
      expect(sign_in_page.success_flash_text).to eq(success_message)
    end
  end

  context 'with email in uppercase' do
    it 'user receives email' do
      forgot_pass_page.reset_password_with(user.email.upcase)

      expect(home_page).to be_displayed
      expect(home_page.success_flash_text).to eq(success_message)
    end
  end
end
