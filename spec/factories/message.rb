FactoryGirl.define do
  factory :message do
    text       { generate(:string) }
  end
end