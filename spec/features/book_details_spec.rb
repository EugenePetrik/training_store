RSpec.describe 'BookDetails' do
  let(:book_details_page) { BookDetailsPage.new }
  let!(:book) { create(:book, :with_author) }

  before { book_details_page.load(book_slug: book.slug) }

  context 'when open page' do
    it { expect(book_details_page.title).to eq('Bookstore') }
    it { expect(book_details_page).to be_displayed(book_slug: book.slug) }
    it { expect(book_details_page).to be_all_there }

    it 'shows book details' do
      book_author = "#{Author.last.first_name} #{Author.last.last_name}"
      book_price = "€ #{book.price}"
      book_description = "#{book.description[0, 100]}..."
      book_dimensions = "H:#{book.height}\" x W: #{book.width}\" x D: #{book.depth}"

      expect(book_details_page.book_title.text).to eq(book.title)
      expect(book_details_page.book_author_title.text).to include(book_author)
      expect(book_details_page.book_price_title.text).to include(book_price)
      expect(book_details_page.book_short_desc_field.text).to include(book_description)
      expect(book_details_page.book_year_field.text).to include('1970-01-01')
      expect(book_details_page.book_dimensions_field.text).to include(book_dimensions)
      expect(book_details_page.book_material_field.text).to include(book.material)
    end
  end
end
