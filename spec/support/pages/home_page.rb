require_relative '../sections/book_section'

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

  element :shop_quantity, 'a.hidden-xs span.shop-quantity'

  expected_elements :sign_up_link, :login_link, :filters_title, :catalog_title

  sections :books, ::BookSection, 'div.book_section'

  def get_category_name_and_count_by_index(index)
    within(:xpath, "(//ul/li[contains(@class, 'category_info')])[#{index}]") do
      block_given? ? yield : raise('There are no parameters for spec')
    end
  end

  def click_on_view_more_button
    view_more_button.click
  end

  def book_titles
    books.map(&:title).map(&:text)
  end

  def user_log_out
    user_email.hover
    log_out.click
  end

  def add_to_shop_book_with(name)
    within(:xpath, "//p[normalize-space()='#{name}']/../../div[1]") do
      find(:xpath, './/img[@alt="design-book"]').hover
      find(:xpath, './/a[contains(@class, "by_book_link")]').click
    end
  end

  def open_book_details_with(name)
    within(:xpath, "//p[normalize-space()='#{name}']/../../div[1]") do
      find(:xpath, './/img[@alt = "design-book"]').hover
      find(:xpath, './/a[@class = "thumb-hover-link"]').click
    end
  end
end
