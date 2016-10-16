FactoryGirl.define do
  sequence(:oauth_uid) do |n|
    @oauth_uid ||= (1..1000).to_a.shuffle
    @oauth_uid[n]
  end

  factory :user do
    name 'Jeffrey Lebowski'
    email 'jeff@gmail.com'
    username 'jeff@gmail.com'
    provider 'google_oauth2'
    oauth_uid { FactoryGirl.generate(:oauth_uid) }
  end
end
