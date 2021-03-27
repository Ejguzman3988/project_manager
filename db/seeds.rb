count = 0
total = 100

# 10.times do 
#     system('clear')
#     count +=1
#     puts("#{count/(total.to_f)*100}%")
#     User.create(
#         name: Faker::Name.name, 
#         username: Faker::Internet.username, 
#         password: "testtest"
#     )
# end
# puts "Created Random users"

# puts "Creating Projects"

# total.times do
#     system('clear')
#     count +=1
#     puts("#{count/(total.to_f)*100}%")
    
#     Project.create(
#         name: Faker::App.name,
#         description: Faker::Quote.yoda, 
#         img_link: Faker::Avatar.image, 
#         user_id: User.ids.sample
#     )
# end

# puts "created projects"

total.times do
    system('clear')
    count += 1
    puts("#{count/(total.to_f)*100}%")

    Notification.create( user_id: User.ids.sample, project_id: Project.ids.sample, join_request: [nil, true, false].sample)

end
puts "Added random users to random projects and gave random notifications."



