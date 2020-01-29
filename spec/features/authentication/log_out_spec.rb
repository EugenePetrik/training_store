RSpec.describe 'LogOut' do
  let(:home_page) { HomePage.new }

  let(:user) { create(:user) }

  let(:success_message) { 'Signed out successfully.' }

  before do
    login_as(user)
    home_page.load
  end

  it 'user logs out' do
    home_page.user_log_out

    expect(home_page).to be_displayed
    expect(home_page.success_flash.text).to eq(success_message)
  end
end
