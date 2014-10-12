namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_studies
  end
end

def make_users
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


def make_studies
  users = User.all(limit: 6)
  50.times do
    name = Faker::Commerce.color + " line"
    description = Faker::Commerce.product_name
    category = Faker::Commerce.department(1, true)
    start_time = Faker::Time.between(1.year.ago, 1.hour.ago)
    end_time = Faker::Time.between(start_time, Time.now)
    
    users.each { |user| user.linestudies.create!(
                              name: name, 
                              description: description, 
                              category: category, 
                              start_time: start_time,
                              end_time: end_time) }
  end  
end

