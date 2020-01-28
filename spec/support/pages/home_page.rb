class HomePage < BasePage
  set_url '/'

  element :sign_up_link, 'a[href="/users/sign_up"]'
  element :login_link, 'a[href="/users/sign_in"]'

  element :user_email, '.user_email > a'
  element :setting, 'a[href="/settings"]'
  element :log_out, 'a[href="/users/sign_out"]'

  element :filters_title, '#filters h1'
  element :catalog_title, 'h1.general-title-margin'

  element :category_name, :xpath, './/a'
  element :category_count, :xpath, './/span'

  element :no_books_title, '#no_books h2'
  element :no_books_image, '#no_books img'

  element :view_more_button, '#view_more'

  elements :book_title, 'div p.title'

  delegate :text, to: :user_email, prefix: true
  delegate :text, to: :filters_title, prefix: true
  delegate :text, to: :catalog_title, prefix: true
  delegate :text, to: :no_books_title, prefix: true
  delegate :text, to: :category_name, prefix: true
  delegate :text, to: :category_count, prefix: true

  delegate :size, to: :book_title, prefix: true

  def no_books_image_source
    no_books_image[:src]
  end

  def get_category_name_and_count_by_index(index)
    within(:xpath, "(//ul/li[contains(@class, 'category_info')])[#{index}]") do
      yield
    end
  end

  def click_on_view_more_button
    view_more_button.click
  end

  def books_titles
    book_title.map(&:text)
  end

  def user_log_out
    user_email.hover
    log_out.click
  end
end
