require_relative '../../sections/settings/address/billing_section'
require_relative '../../sections/settings/address/shipping_section'

class SettingsPage < BasePage
  set_url '/settings'

  element :title, 'h1', text: /settings/i
  element :billing_title, 'h3', text: /billing address/i
  element :shipping_title, 'h3', text: /shipping address/i

  section :billing_address, ::BillingSection, '.billing_address_section'
  section :shipping_address, ::ShippingSection, '.shipping_address_section'
end
