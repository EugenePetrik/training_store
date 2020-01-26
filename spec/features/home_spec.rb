RSpec.describe 'Home' do
  let(:home_page) { HomePage.new }

  context 'without books' do
    before { visit '/' }

    it 'shows no books title' do
      expect(home_page.filters_title_text).to include('Filters')
      expect(home_page.catalog_title_text).to include('Catalog')
      expect(home_page.no_books_title_text).to include('Can`t find books')
    end

    it 'shows no books image' do
      file_src = '/assets/fallback/no_books-0a35a1b14b85c223a9d0c8bf0ea4cd29588f68cb35744963bb6c12d365118919.jpg'
      expect(home_page.no_books_image_source).to include(file_src)
    end

    it 'shows ALL link with 0 count' do
      home_page.get_category_name_and_count_by_index(1) do
        expect(home_page.category_name_text).to include('All')
        expect(home_page.category_count_text).to include('0')
      end
    end
  end

  context 'with books' do
    let(:mob) { create(:category, title: 'Mobile development') }
    let(:web) { create(:category, title: 'Web development') }

    let!(:mob_books) { create_list(:book, 7, category: mob) }
    let!(:web_books) { create_list(:book, 6, category: web) }

    before { visit '/' }

    it 'shows all books' do
      home_page.click_on_view_more_button

      home_page.has_no_view_more_button?

      expect(home_page.book_title_size).to eq(13)
      expect(home_page.books_titles).to match_array([
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
        expect(home_page.category_name_text).to include('All')
        expect(home_page.category_count_text).to include('13')
      end

      home_page.get_category_name_and_count_by_index(2) do
        expect(home_page.category_name_text).to include('Mobile development')
        expect(home_page.category_count_text).to include('7')
      end

      home_page.get_category_name_and_count_by_index(3) do
        expect(home_page.category_name_text).to include('Web development')
        expect(home_page.category_count_text).to include('6')
      end
    end
  end
end
