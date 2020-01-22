RSpec.describe 'Home page' do
  context 'without books' do
    before { visit '/' }

    it 'shows no books image' do
      expect(page).to have_content('Catalog')
      expect(page).to have_content('Can`t find books')

      file_src = '/assets/fallback/no_books-0a35a1b14b85c223a9d0c8bf0ea4cd29588f68cb35744963bb6c12d365118919.jpg'
      expect(find('#no_books img')[:src]).to include(file_src)
    end

    it 'shows ALL link with 0 count' do
      within(:xpath, '(//ul[contains(@class, "list-inline")]/li)[1]') do
        # expect(page).to have_xpath('.//a', text: 'All')
        # expect(page).to have_xpath('.//span', text: '0')
        expect(find(:xpath, './/a').text).to include('All')
        expect(find(:xpath, './/span').text).to eq('0')
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
      find('#view_more').click

      expect(page).not_to have_css('#view_more')

      all_books = all(:css, 'div p.title')

      expect(all_books.size).to eq(13)
      expect(all_books.map(&:text)).to match_array([
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
      expect(page).to have_css('#view_more')
    end

    it 'shows correct category name and books count' do
      within(:xpath, '(//ul[contains(@class, "list-inline")]/li)[1]') do
        expect(find(:xpath, './/a').text).to include('All')
        expect(find(:xpath, './/span').text).to eq('13')
      end

      within(:xpath, '(//ul[contains(@class, "list-inline")]/li)[2]') do
        expect(find(:xpath, './/a').text).to include('Mobile development')
        expect(find(:xpath, './/span').text).to eq('7')
      end

      within(:xpath, '(//ul[contains(@class, "list-inline")]/li)[3]') do
        expect(find(:xpath, './/a').text).to include('Web development')
        expect(find(:xpath, './/span').text).to eq('6')
      end
    end
  end
end
