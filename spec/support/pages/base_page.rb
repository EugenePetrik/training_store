class BasePage < SitePrism::Page
  element :success_flash, '.alert-success'
  element :error_flash, '.alert-danger'
end
