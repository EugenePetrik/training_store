RSpec.describe 'Order' do
  let(:order_page) { OrderPage.new }
  let(:user) { create(:user, :with_order) }

  before do
    login_as(user)
    order_page.load
  end

  context 'when open page' do
    it { expect(order_page.title).to eq('Bookstore') }
    it { expect(order_page).to be_displayed }
    it { expect(order_page).to be_all_there }
    it { expect(order_page).to have_number_ordered_books(count: 1) }
  end
end
