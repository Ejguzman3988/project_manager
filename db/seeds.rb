user.create(name: "Robo" username: "test" password: "testtest")

user.create(name: "Robo2" username: "test2" password: "testtest")

(1..20).to_a.each do |num|
    Project.create(name: "Project. #{num}")
end

Project.all.each do |project|
    project.update(user_id: [1, 2].sample)
end
