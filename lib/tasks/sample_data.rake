namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    User.create!(name: "Example User",
                 email: "example@quickstudy.ukcom",
                 organization: "Example company",
                 password: "foobar",
                 password_confirmation: "foobar", 
                 admin: true)
    99.times do |n|
      name  = Faker::Name.name
      email = Faker::Internet.email(Faker::Name.last_name + (n+1).to_s)
      organization = Faker::Company.name
      password  = "password"
      User.create!(name: name,
                   email: email,
                   organization: organization,
                   password: password,
                   password_confirmation: password)
    end
  end
end