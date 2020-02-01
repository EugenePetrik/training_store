class BookSection < SitePrism::Section
  element :title, 'p.title'
  element :price, 'p.price'
  element :author, 'p.author'
end
