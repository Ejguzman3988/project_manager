# 10.times do 
#     User.create(
#         name: Faker::Name.name, 
#         username: Faker::Internet.username, 
#         password: "testtest"
#     )
# end


puts "Creating Projects"
count = 0
total = 1000
total.times do
    system('clear')
    count +=1
    puts("#{count/(total.to_f)*100}%")
    
    Project.create(
        name: Faker::App.name,
        description: Faker::Quote.yoda, 
        img_link: Faker::Avatar.image, 
        user_id: User.ids.sample
    )
end
puts "created projects"
