class RemoveAccountSection < SitePrism::Section
  element :checkbox_delete_account, 'span.checkbox-text'
  element :delete_account_button, '#delete_account'
end
