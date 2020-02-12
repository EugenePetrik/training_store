RSpec.describe 'LogOut' do
  let(:home_page) { HomePage.new }
  let(:user) { create(:user) }
  let(:success_message) { I18n.t('devise.sessions.signed_out') }

  before do
    login_as(user)
    home_page.load
  end

  it 'user logs out' do
    home_page.user_log_out

    expect(home_page).to be_displayed
    expect(home_page.success_flash.text).to eq(success_message)
    expect(home_page).to have_no_user_email
    expect(home_page).to have_sign_up_link
    expect(home_page).to have_login_link
  end
end
