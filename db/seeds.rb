user = User.find_by(email: 'test@mail.com') || User.create!(email: 'test@mail.com', password: 'asdfasdf', password_confirmation: 'asdfasdf')
category = Category.create! user: user, name: SecureRandom.alphanumeric(4)
item = Item.create! user: user, name: SecureRandom.alphanumeric(3), categories: [category]
dash = Dashboard.create! user: user, name: SecureRandom.alphanumeric(5)
display = Display.create!(user: user, name: SecureRandom.alphanumeric(4), dashboard: dash,
                          sources: [Source.new(sourceable: item), Source.new(sourceable: category)])
15.times do
  entry = Entry.create! user: user, item: item, date: rand(1.years).seconds.ago, amount: rand(231)
end

10.times do
  item = Item.create! user: user, name: SecureRandom.alphanumeric(3), categories: [category]
  entry = Entry.create! user: user, item: item, amount: SecureRandom.random_number(100), date: rand(1.years).seconds.ago
end
