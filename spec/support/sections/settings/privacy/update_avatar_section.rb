class UpdateAvatarSection < SitePrism::Section
  element :save_button, '[name="commit"]'

  def update_avatar_with(file_name)
    path = File.absolute_path("./spec/support/files/#{file_name}")

    attach_file('upload_image_image', path)
    save_button.click
  end
end
