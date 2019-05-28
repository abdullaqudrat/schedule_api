require 'rails_helper'

describe 'Schedule API' do
  let(:name) { "planner" }
  let(:complex_name) { "Abdulla's-Schedule" }
  let(:apt_name_1) { "dentist" }
  let(:apt_name_2) { "kids" }
  let(:apt_name_3) { "party" }
  let(:start_time_1) { "1" }
  let(:end_time_1) { "2" }
  let(:start_time_2) { "3" }
  let(:end_time_2) { "4" }
  let(:start_time_3) { "5" }
  let(:end_time_3) { "6" }
  
  it 'can create a schedule' do

    post "/api/v1/schedule?name=#{name}"

    json_response = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(json_response).to be_a(Hash)
    expect(json_response).to have_key(:message)
    expect(json_response[:message]).to eq("Schedule 'planner' created")
  end
  it 'can create a schedule' do

    post "/api/v1/schedule?name=#{complex_name}"

    json_response = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(json_response).to be_a(Hash)
    expect(json_response).to have_key(:message)
    expect(json_response[:message]).to eq("Schedule 'Abdulla's Schedule' created")
  end
  it 'fails to create a schedule with no params' do

    post "/api/v1/schedule"

    json_response = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(json_response).to be_a(Hash)
    expect(json_response).to have_key(:message)
    expect(json_response[:message]).to eq("error")
  end
  it 'can show a schedule' do

    post "/api/v1/schedule?name=#{name}"

    expect(response).to be_successful

    get "/api/v1/schedule/#{name}"

    json_response = JSON.parse(response.body, symbolize_names: true)
    expect(response).to be_successful
    expect(json_response).to be_a(Hash)
    expect(json_response).to have_key(:name)
    expect(json_response[:name]).to eq("planner")
  end
  it 'can show a schedule' do

    post "/api/v1/schedule?name=#{complex_name}"

    expect(response).to be_successful

    get "/api/v1/schedule/#{complex_name}"

    json_response = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(json_response).to be_a(Hash)
    expect(json_response).to have_key(:name)
    expect(json_response[:name]).to eq("Abdulla's Schedule")
  end
  it 'fails to show a schedule' do

    post "/api/v1/schedule?name=#{name}"

    expect(response).to be_successful

    get "/api/v1/schedule/myplanner"

    json_response = JSON.parse(response.body, symbolize_names: true)
    expect(response).to be_successful
    expect(json_response).to be_a(Hash)
    expect(json_response).to have_key(:message)
    expect(json_response[:message]).to eq("error")
  end
  it 'can delete a schedule' do

    post "/api/v1/schedule?name=#{name}"

    expect(response).to be_successful

    get "/api/v1/schedule/#{name}"

    expect(response).to be_successful

    delete "/api/v1/schedule/#{name}"

    json_response = JSON.parse(response.body, symbolize_names: true)
    expect(response).to be_successful
    expect(json_response).to be_a(Hash)
    expect(json_response).to have_key(:message)
    expect(json_response[:message]).to eq("Deleted schedule")
  end
  it 'fails to delete a schedule that doesnt exist' do

    delete "/api/v1/schedule/#{name}"

    delete "/api/v1/schedule/#{name}"

    json_response = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful

    expect(json_response).to be_a(Hash)
    expect(json_response).to have_key(:message)
    expect(json_response[:message]).to eq("error")
  end
  it 'can show an appointments for given schedule' do

    post "/api/v1/schedule?name=#{name}"

    expect(response).to be_successful

    post "/api/v1/schedule/#{name}/appointment?name=#{apt_name_1}&start_time=#{start_time_1}&end_time=#{end_time_1}"

    expect(response).to be_successful

    post "/api/v1/schedule/#{name}/appointment?name=#{apt_name_2}&start_time=#{start_time_2}&end_time=#{end_time_2}"

    expect(response).to be_successful

    post "/api/v1/schedule/#{name}/appointment?name=#{apt_name_3}&start_time=#{start_time_3}&end_time=#{end_time_3}"

    expect(response).to be_successful

    get "/api/v1/schedule/#{name}"

    json_response = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(json_response).to be_a(Hash)
    expect(json_response).to have_key(:name)
    expect(json_response[:name]).to eq(name)
    expect(json_response).to have_key(:appointments)
    expect(json_response[:appointments]).to be_a(Array)
    expect(json_response[:appointments].count).to eq(3)
    expect(json_response[:appointments][0]).to have_key(:name)
    expect(json_response[:appointments][0][:name]).to eq(apt_name_1)
    expect(json_response[:appointments][0]).to have_key(:start_time)
    expect(json_response[:appointments][0][:start_time]).to eq(start_time_1)
    expect(json_response[:appointments][0]).to have_key(:end_time)
    expect(json_response[:appointments][0][:end_time]).to eq(end_time_1)
    expect(json_response[:appointments][1]).to have_key(:name)
    expect(json_response[:appointments][1][:name]).to eq(apt_name_2)
    expect(json_response[:appointments][1]).to have_key(:start_time)
    expect(json_response[:appointments][1][:start_time]).to eq(start_time_2)
    expect(json_response[:appointments][1]).to have_key(:end_time)
    expect(json_response[:appointments][1][:end_time]).to eq(end_time_2)
    expect(json_response[:appointments][2]).to have_key(:name)
    expect(json_response[:appointments][2][:name]).to eq(apt_name_3)
    expect(json_response[:appointments][2]).to have_key(:start_time)
    expect(json_response[:appointments][2][:start_time]).to eq(start_time_3)
    expect(json_response[:appointments][2]).to have_key(:end_time)
    expect(json_response[:appointments][2][:end_time]).to eq(end_time_3)

    delete "/api/v1/schedule/planner/appointment/#{apt_name_1}"

    get "/api/v1/schedule/#{name}"

    new_response = JSON.parse(response.body, symbolize_names: true)

    expect(new_response[:appointments].count).to eq(2)
  end
  it 'can show an appointments for given schedule in order by soonest first' do

    post "/api/v1/schedule?name=#{name}"

    expect(response).to be_successful

    post "/api/v1/schedule/#{name}/appointment?name=#{apt_name_2}&start_time=#{start_time_2}&end_time=#{end_time_2}"
    
    expect(response).to be_successful
    
    post "/api/v1/schedule/#{name}/appointment?name=#{apt_name_3}&start_time=#{start_time_3}&end_time=#{end_time_3}"
    
    expect(response).to be_successful
    
    post "/api/v1/schedule/#{name}/appointment?name=#{apt_name_1}&start_time=#{start_time_1}&end_time=#{end_time_1}"

    expect(response).to be_successful

    get "/api/v1/schedule/#{name}"

    json_response = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(json_response).to be_a(Hash)
    expect(json_response).to have_key(:name)
    expect(json_response[:name]).to eq(name)
    expect(json_response).to have_key(:appointments)
    expect(json_response[:appointments]).to be_a(Array)
    expect(json_response[:appointments].count).to eq(3)
    expect(json_response[:appointments][0]).to have_key(:name)
    expect(json_response[:appointments][0][:name]).to eq(apt_name_1)
    expect(json_response[:appointments][0]).to have_key(:start_time)
    expect(json_response[:appointments][0][:start_time]).to eq(start_time_1)
    expect(json_response[:appointments][0]).to have_key(:end_time)
    expect(json_response[:appointments][0][:end_time]).to eq(end_time_1)
    expect(json_response[:appointments][1]).to have_key(:name)
    expect(json_response[:appointments][1][:name]).to eq(apt_name_2)
    expect(json_response[:appointments][1]).to have_key(:start_time)
    expect(json_response[:appointments][1][:start_time]).to eq(start_time_2)
    expect(json_response[:appointments][1]).to have_key(:end_time)
    expect(json_response[:appointments][1][:end_time]).to eq(end_time_2)
    expect(json_response[:appointments][2]).to have_key(:name)
    expect(json_response[:appointments][2][:name]).to eq(apt_name_3)
    expect(json_response[:appointments][2]).to have_key(:start_time)
    expect(json_response[:appointments][2][:start_time]).to eq(start_time_3)
    expect(json_response[:appointments][2]).to have_key(:end_time)
    expect(json_response[:appointments][2][:end_time]).to eq(end_time_3)
  end
  it 'cannot add overlapping appointments for given schedule' do

    post "/api/v1/schedule?name=#{name}"

    json_response = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful

    post "/api/v1/schedule/#{name}/appointment?name=#{apt_name_2}&start_time=#{start_time_2}&end_time=#{end_time_2}"
    
    json_response = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(json_response).to be_a(Hash)
    expect(json_response).to have_key(:message)
    expect(json_response[:message]).to eq("Added kids to planner")

    post "/api/v1/schedule/#{name}/appointment?name=#{apt_name_3}&start_time=#{start_time_3}&end_time=#{end_time_3}"
    
    json_response = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(json_response).to be_a(Hash)
    expect(json_response).to have_key(:message)
    expect(json_response[:message]).to eq("Added party to planner")    

    post "/api/v1/schedule/#{name}/appointment?name=#{apt_name_1}&start_time=#{start_time_1}&end_time=#{end_time_3}"

    json_response = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(json_response).to be_a(Hash)
    expect(json_response).to have_key(:message)
    expect(json_response[:message]).to eq("error")

    get "/api/v1/schedule/#{name}"

    json_response = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(json_response).to be_a(Hash)
    expect(json_response).to have_key(:name)
    expect(json_response[:name]).to eq(name)
    expect(json_response).to have_key(:appointments)
    expect(json_response[:appointments]).to be_a(Array)
    expect(json_response[:appointments].count).to eq(2)
    expect(json_response[:appointments][0]).to have_key(:name)
    expect(json_response[:appointments][0][:name]).to eq(apt_name_2)
    expect(json_response[:appointments][0]).to have_key(:start_time)
    expect(json_response[:appointments][0][:start_time]).to eq(start_time_2)
    expect(json_response[:appointments][0]).to have_key(:end_time)
    expect(json_response[:appointments][0][:end_time]).to eq(end_time_2)
    expect(json_response[:appointments][1]).to have_key(:name)
    expect(json_response[:appointments][1][:name]).to eq(apt_name_3)
    expect(json_response[:appointments][1]).to have_key(:start_time)
    expect(json_response[:appointments][1][:start_time]).to eq(start_time_3)
    expect(json_response[:appointments][1]).to have_key(:end_time)
    expect(json_response[:appointments][1][:end_time]).to eq(end_time_3)
  end
end