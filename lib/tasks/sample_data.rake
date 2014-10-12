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
    
    users.each do |user| 
      l = user.linestudies.create!( name: name, 
                              description: description, 
                              category: category, 
                              start_time: start_time,
                              end_time: end_time)
      add_events(l)
    end
  end  
end

def add_events(linestudy)
  stats = ['Running', 'Idle', 'Down']
  e_js = 1
  e_desc = Faker::Lorem.words(1)[0].to_s.capitalize + " event description"
  e_start = Faker::Time.between(1.year.ago, 12.hours.ago)
  e_stop = e_start + rand(120).seconds

  5.times do
    linestudy.events.create!(
      event_start: e_start, 
      event_stop: e_stop,
      event_description: e_desc,
      status: stats[rand(3)],
      speed: rand(750),
      js_id: e_js,
      linestudy_id: linestudy.id,
      user_id: linestudy.user_id)
  end
  e_js += 1
  e_start = e_stop
  e_stop = e_start + rand(120)
end
