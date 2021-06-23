User.create!(name: "Sub22",
             email: "sub22@gmail.com",
             password: "123456789",
             password_confirmation: "123456789",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)
20.times do |n|
  name = "Tung0#{n+1}"
  email = "example-#{n+1}@gmail.com"
  password = "password"
User.create! name: name,
             email: email,
             password: password,
             password_confirmation: password,
             activated: true,
             activated_at: Time.zone.now
end

Category.destroy_all
5.times do |n|
  c = Category.create(name: "Cat0#{n+1}")
  puts "Create #{c.name}"
  downloaded_image = URI.open("https://source.unsplash.com/600x600/?coffee#{n+1}")
  c.image.attach(io: downloaded_image, filename: "m-#{c.name}.jpg")
end

Product.destroy_all
10.times do |n|
  p = Product.create!(name: "CoffeeA#{n+1}",
                    old_price: rand(1..20),
                    price: rand(1..10),
                    category_id: rand(1..5),
                    information: "Coffee Infor#{n+1}")
  puts "Creating #{p.name}"

  downloaded_image = URI.open("https://source.unsplash.com/600x600/?coffee#{n+1}")
  p.image.attach(io: downloaded_image, filename: "m-#{p.name}.jpg")
end
