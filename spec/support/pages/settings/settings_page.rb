require_relative '../../sections/settings/address/billing_section'
require_relative '../../sections/settings/address/shipping_section'

require_relative '../../sections/settings/privacy/remove_account_section'
require_relative '../../sections/settings/privacy/update_avatar_section'
require_relative '../../sections/settings/privacy/update_email_section'
require_relative '../../sections/settings/privacy/update_password_section'

class SettingsPage < BasePage
  set_url '/settings'

  element :title, 'h1', text: /settings/i
  element :billing_title, 'h3', text: /billing address/i
  element :shipping_title, 'h3', text: /shipping address/i

  element :image_circle, 'img.img-circle'
  element :avatar_icons_title, 'h3', text: I18n.t('settings.avatar_icons')

  element :address_tab, 'a[href="#address"]'
  element :privacy_tab, 'a[href="#privacy"]'

  expected_elements :title, :billing_title, :shipping_title, :address_tab,
                    :privacy_tab, :image_circle, :avatar_icons_title

  section :billing_address, ::BillingSection, '.billing_address_section'
  section :shipping_address, ::ShippingSection, '.shipping_address_section'

  section :update_email, ::UpdateEmailSection, '#edit_email_form'
  section :update_avatar, ::UpdateAvatarSection, '#edit_upload_image'
  section :remove_account, ::RemoveAccountSection, '[id ^=edit_user]'
  section :update_password, ::UpdatePasswordSection, '#edit_password_form'
end
