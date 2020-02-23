RSpec.describe 'Home' do
  let(:home_page) { HomePage.new }

  context 'when open page' do
    before { home_page.load }
    
    it { expect(home_page).to be_displayed }
    it { expect(home_page).to be_all_there }
    it { expect(home_page.title).to eq('Bookstore') }
  end
  
  context 'without books' do
    before { home_page.load }

    it 'shows no books title' do
      expect(home_page.filters_title.text).to include(I18n.t('filters.title'))
      expect(home_page.catalog_title.text).to include(I18n.t('catalog.title'))
      expect(home_page.no_books_title.text).to include(I18n.t('filters.can_not_find_books'))
    end

    it 'shows no books image' do
      file_src = '/assets/fallback/no_books'
      expect(home_page.get_image_src_attr(home_page.no_books_image)).to include(file_src)
    end

    it 'shows ALL link with 0 count' do
      home_page.get_category_name_and_count_by_index(1) do
        expect(home_page.category_name.text).to include('All')
        expect(home_page.category_count.text).to include('0')
      end
    end
  end

  context 'with books' do
    let(:mob) { create(:category, title: 'Mobile development') }
    let(:web) { create(:category, title: 'Web development') }

    let!(:mob_books) { create_list(:book, 7, category: mob) }
    let!(:web_books) { create_list(:book, 6, category: web) }

    before { home_page.load }

    it 'shows all books' do
      home_page.click_on_view_more_button

      home_page.has_no_view_more_button?

      expect(home_page).to have_books(count: 13)
      expect(home_page.book_titles).to match_array([
                                                     mob_books[0].title, mob_books[1].title,
                                                     mob_books[2].title, mob_books[3].title,
                                                     mob_books[4].title, mob_books[5].title,
                                                     mob_books[6].title,
                                                     web_books[0].title, web_books[1].title,
                                                     web_books[2].title, web_books[3].title,
                                                     web_books[4].title, web_books[5].title,
                                                   ])
    end

    it 'shows pagination when more than 12 books created' do
      # home_page.has_view_more_button?
      expect(home_page).to have_view_more_button
    end

    it 'shows correct category name and books count' do
      home_page.get_category_name_and_count_by_index(1) do
        expect(home_page.category_name.text).to include('All')
        expect(home_page.category_count.text).to include('13')
      end

      home_page.get_category_name_and_count_by_index(2) do
        expect(home_page.category_name.text).to include('Mobile development')
        expect(home_page.category_count.text).to include('7')
      end

      home_page.get_category_name_and_count_by_index(3) do
        expect(home_page.category_name.text).to include('Web development')
        expect(home_page.category_count.text).to include('6')
      end
    end
  end

  context 'when click on' do
    let!(:book) { create(:book, :with_author) }
  
    before { home_page.load }

    context 'add to shop button' do
      it 'increases shop quantity' do
        home_page.add_to_shop_book_with(book.title)

        expect(home_page.shop_quantity.text).to include('1')
      end
    end
  
    context 'book details button' do
      let(:book_details_page) { BookDetailsPage.new }

      it 'opens book details page' do
        home_page.open_book_details_with(book.title)

        expect(book_details_page).to be_displayed(book_slug: book.slug)
        expect(book_details_page).to be_all_there

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
end
