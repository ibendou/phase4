FactoryBot.define do
 
  factory :employee do
    first_name { "Ed" }
    last_name { "Gruberman" }
    ssn { rand(9 ** 9).to_s.rjust(9,'0') }
    date_of_birth { 19.years.ago.to_date }
    phone { rand(10 ** 10).to_s.rjust(10,'0') }
    role { "employee" }
    active { true }
  end
  
  factory :store do
    name {"CMU"}
    street {"5000 Forbes Avenue"}
    city {"Pittsburgh"}
    state {"PA"}
    zip {"15213"}
    phone { rand(10 ** 10).to_s.rjust(10,'0') }
    active {true}
  end
  
  factory :assignment do
    association :store
    association :employee
    start_date {1.year.ago.to_date}
    end_date {1.month.ago.to_date}
    pay_level {1}
  end

  factory :user do
    association :employee
    email {"egruberman@gmail.com"}
   # password {"password"}
  end
  
  factory :shift do
    association :assignment
    date { 2.days.ago.to_date }
    start_time { 2.days.ago.to_date.change(hours:13,minutes:0,seconds:0) }
    end_time{ 1.days.ago.to_date.change(hours:22,minutes:0,seconds:0) }
    notes { "some notes about this shift" }
  end
  
  factory :flavor do
    name {"Vanilla"}
    active { true }
  end
  

  factory :store_flavor do
    store_id {1}
    flavor_id {1}
  end

  factory :job do
    name {"making icecream"}
    description { "The empoyee makes icecream using the secret recipe" }
    active { true }
  end


  factory :shift_job do
    job_id {1}
    shift_id {1}
  end

end
