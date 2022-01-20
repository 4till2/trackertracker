user = User.find_by(email: 'test@mail.com') || User.create!(email: 'test@mail.com', password: 'asdfasdf', password_confirmation: 'asdfasdf')
categorya = Category.create! user: user, name: "EXERCISE"
categoryb = Category.create! user: user, name: "HEALTH"
itema = Item.create! user: user, name: "Push Ups", categories: [categorya, categoryb]
itemb = Item.create! user: user, name: "Sleep", categories: [categoryb]
# dash = Dashboard.create! user: user, name: SecureRandom.alphanumeric(5)
# display = Display.create!(user: user, name: SecureRandom.alphanumeric(4), dashboard: dash,
#                           sources: [Source.new(sourceable: item), Source.new(sourceable: category)])
25.times do
  Entry.create! user: user, item: itema, date: rand(1.month).seconds.ago, amount: rand(42)
  Entry.create! user: user, item: itemb, date: rand(1.month).seconds.ago, amount: rand(5..10)
end