class BasePage < SitePrism::Page
  element :success_flash, '.alert-success'
  element :error_flash, '.alert-danger'

  delegate :text, to: :success_flash, prefix: true
  delegate :text, to: :error_flash, prefix: true
end
