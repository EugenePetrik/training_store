class BasePage < SitePrism::Page
  element :success_flash, '.alert-success'
  element :error_flash, '.alert-danger'

  def get_image_src_attr(element)
    element[:src]
  end
end
