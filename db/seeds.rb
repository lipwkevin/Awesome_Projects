10.times do
  u = User.create({
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    password_digest: '12345'
  })
end


3.times do
  Project.create({
      title:Faker::Commerce.product_name,
      description: Faker::Hacker.say_something_smart,
      deadline: Faker::Time.forward(23, :morning),
      status: "not completed"
  })
end

10.times do
  Goal.create({
      title:Faker::Book.title,
      description: Faker::Hacker.say_something_smart,
      deadline: Faker::Time.forward(23, :morning),
      project_id: rand(3)+1
    })
end
#
30.times do
  Task.create({
      title: Faker::Superhero.power,
      deadline: Faker::Time.forward(23, :morning),
      goal_id: rand(10)+1
    })
end
