# User.create(name: "Robo", username: "test", password: "testtest")

# User.create(name: "Robo2", username: "test2", password: "testtest")

# (1..20).to_a.each do |num|
#     Project.create(name: "Project. #{num}")
# end

# Project.all.each do |project|
#     project.update(user_id: [1, 2].sample)
#     User.find(project.user_id).projects << project
# end

(1..20).to_a.each do |num|
    Task.create(name: "Task. #{num}", user_id: [1,2].sample, project_id: Project.ids.sample)

end
