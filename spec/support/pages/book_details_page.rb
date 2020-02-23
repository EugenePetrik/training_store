class BookDetailsPage < BasePage
  set_url '/books/{book_slug}'

  element :back_link, 'a.general-back-link'
  element :reviews_title, '.reviews_title'

  element :book_title, 'div h1'
  element :book_author_title, 'p.book-author'
  element :book_price_title, 'p.h1'
  element :add_to_card_button, 'input[value="Add to card"]'

  element :description_title, 'p.description-title', text: I18n.t('book.description_title')
  element :book_short_desc_field, '#short-desc'

  element :book_year_title, 'p.year-title', text: I18n.t('book.release')
  element :book_year_field, 'div.year p.lead'

  element :book_dimensions_title, 'p.dimensions-title', text: I18n.t('book.dimensions')
  element :book_dimensions_field, 'div.dimensions p.lead'

  element :book_material_title, 'p.material-title', text: I18n.t('book.material_title')
  element :book_material_field, 'div.material p.lead'
end
