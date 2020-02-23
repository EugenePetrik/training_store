class OrderPage < BasePage
  set_url '/cart'

  element :cart_title, 'h1'

  element :order_summary_title, 'p.cart-summary'
  element :sub_total_title, 'p.cart-subtotal'
  element :coupon_title, 'p.cart-coupon'
  element :order_total_title, 'strong.cart-order-total'

  elements :number_ordered_books, 'tr.books-order'
end
