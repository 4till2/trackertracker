user = User.create! email: 'test@mail.com', password: 'asdfasdf', password_confirmation: 'asdfasdf'
category = Category.create! user: user, name: SecureRandom.alphanumeric(4)
item = Item.create! user: user, name: SecureRandom.alphanumeric(3), categories: [category]
dash = Dashboard.create! user: user, name: SecureRandom.alphanumeric(5)
display = Display.create!(user: user, name: SecureRandom.alphanumeric(4), dashboard: dash,
                          sources: [Source.new(sourceable: item), Source.new(sourceable: category)])
5.times do
  entry = Entry.create! user: user, item: item
end

10.times do
  item = Item.create! user: user, name: SecureRandom.alphanumeric(3), categories: [category]
  entry = Entry.create! user: user, item: item, amount: SecureRandom.random_number(100)
end
