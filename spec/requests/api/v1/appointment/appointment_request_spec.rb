require 'rails_helper'

describe 'Appointment API' do
  let(:name) { "dentist" }
  let(:complex_name) { "dentist-office-at-10" }
  let(:start_time) { 1 }
  let(:end_time) { 2 }
  let(:bad_start_time) { 2 }

  it 'can create a appointment' do

  post "/api/v1/schedule?name=planner"

  expect(response).to be_successful

  post "/api/v1/schedule/planner/appointment?name=#{name}&start_time=#{start_time}&end_time=#{end_time}"

  json_response = JSON.parse(response.body, symbolize_names: true)

  expect(response).to be_successful
  expect(json_response).to be_a(Hash)
  expect(json_response).to have_key(:message)
  expect(json_response[:message]).to eq("Added dentist to planner")
  end
  it 'can create a appointment with complex name' do

  post "/api/v1/schedule?name=planner"

  expect(response).to be_successful

  post "/api/v1/schedule/planner/appointment?name=#{complex_name}&start_time=#{start_time}&end_time=#{end_time}"

  json_response = JSON.parse(response.body, symbolize_names: true)

  expect(response).to be_successful
  expect(json_response).to be_a(Hash)
  expect(json_response).to have_key(:message)
  expect(json_response[:message]).to eq("Added dentist office at 10 to planner")
  end
  it 'fails to create a appointment with no params' do

    post "/api/v1/schedule?name=planner"

    expect(response).to be_successful

    post "/api/v1/schedule/planner/appointment"

    json_response = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(json_response).to be_a(Hash)
    expect(json_response).to have_key(:message)
    expect(json_response[:message]).to eq("error")
  end
  it 'fails to create a appointment with no schedule existing' do

    post "/api/v1/schedule/nil/appointment?name=#{name}"

    json_response = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(json_response).to be_a(Hash)
    expect(json_response).to have_key(:message)
    expect(json_response[:message]).to eq("error")
  end
  it 'fails to create a appointment with bad start and end time' do

    post "/api/v1/schedule?name=planner"

    expect(response).to be_successful

    post "/api/v1/schedule/planner/appointment?name=#{name}&start_time=#{bad_start_time}&end_time=#{end_time}"

    json_response = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(json_response).to be_a(Hash)
    expect(json_response).to have_key(:message)
    expect(json_response[:message]).to eq("error")
  end
  it 'can show an appointment' do

    post "/api/v1/schedule?name=planner"

    expect(response).to be_successful

    post "/api/v1/schedule/planner/appointment?name=#{name}&start_time=#{start_time}&end_time=#{end_time}"

    expect(response).to be_successful

    get "/api/v1/schedule/planner/appointment/#{name}"

    json_response = JSON.parse(response.body, symbolize_names: true)
  
    expect(response).to be_successful
    expect(json_response).to be_a(Hash)
    expect(json_response).to have_key(:name)
    expect(json_response[:name]).to eq("dentist")
    expect(json_response).to have_key(:start_time)
    expect(json_response[:start_time]).to eq("1")
    expect(json_response).to have_key(:end_time)
    expect(json_response[:end_time]).to eq("2")
  end
  it 'can show an appointment with complex name' do

    post "/api/v1/schedule?name=planner"

    expect(response).to be_successful

    post "/api/v1/schedule/planner/appointment?name=#{complex_name}&start_time=#{start_time}&end_time=#{end_time}"

    expect(response).to be_successful

    get "/api/v1/schedule/planner/appointment/#{complex_name}"

    json_response = JSON.parse(response.body, symbolize_names: true)
  
    expect(response).to be_successful
    expect(json_response).to be_a(Hash)
    expect(json_response).to have_key(:name)
    expect(json_response[:name]).to eq("dentist office at 10")
    expect(json_response).to have_key(:start_time)
    expect(json_response[:start_time]).to eq("1")
    expect(json_response).to have_key(:end_time)
    expect(json_response[:end_time]).to eq("2")
  end
  it 'fails to show an appointment that doesnt exist' do

    post "/api/v1/schedule?name=planner"

    expect(response).to be_successful

    post "/api/v1/schedule/planner/appointment?name=#{name}&start_time=#{start_time}&end_time=#{end_time}"

    expect(response).to be_successful

    get "/api/v1/schedule/planner/appointment/nil"

    json_response = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(json_response).to be_a(Hash)
    expect(json_response).to have_key(:message)
    expect(json_response[:message]).to eq("error")
  end
  it 'can delete an appointment' do

    post "/api/v1/schedule?name=planner"

    expect(response).to be_successful

    post "/api/v1/schedule/planner/appointment?name=#{name}&start_time=#{start_time}&end_time=#{end_time}"

    expect(response).to be_successful

    get "/api/v1/schedule/planner/appointment/#{name}"
  
    expect(response).to be_successful

    delete "/api/v1/schedule/planner/appointment/#{name}"

    json_response = JSON.parse(response.body, symbolize_names: true)
    expect(response).to be_successful
    expect(json_response).to be_a(Hash)
    expect(json_response).to have_key(:message)
    expect(json_response[:message]).to eq("Deleted appointment")
  end
  it 'fails to delete an appointment that doesnt exist' do

    post "/api/v1/schedule?name=planner"

    expect(response).to be_successful

    delete "/api/v1/schedule/planner/appointment/failed"

    json_response = JSON.parse(response.body, symbolize_names: true)
    expect(response).to be_successful
    expect(json_response).to be_a(Hash)
    expect(json_response).to have_key(:message)
    expect(json_response[:message]).to eq("error")
  end
end