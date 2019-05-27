require 'rails_helper'

describe 'Schedule API' do
  it 'can create a schedule' do
    name = "planner"

    post "/api/v1/schedule?name=#{name}"

    json_response = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(json_response).to be_a(Hash)
    expect(json_response).to have_key(:message)
    expect(json_response[:message]).to eq("Schedule 'planner' created")
  end
  it 'fails to create a schedule with no params' do
    name = "planner"

    post "/api/v1/schedule"

    json_response = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(json_response).to be_a(Hash)
    expect(json_response).to have_key(:message)
    expect(json_response[:message]).to eq("error")
  end
  it 'can show a schedule' do
    name = "planner"

    post "/api/v1/schedule?name=#{name}"

    expect(response).to be_successful

    get "/api/v1/schedule/#{name}"

    json_response = JSON.parse(response.body, symbolize_names: true)
    expect(response).to be_successful
    expect(json_response).to be_a(Hash)
    expect(json_response).to have_key(:name)
    expect(json_response[:name]).to eq("planner")
  end
  it 'fails to show a schedule' do
    name = "planner"

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
    name = "planner"

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
    name = "planner"

    delete "/api/v1/schedule/#{name}"

    delete "/api/v1/schedule/#{name}"

    json_response = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful

    expect(json_response).to be_a(Hash)
    expect(json_response).to have_key(:message)
    expect(json_response[:message]).to eq("error")
  end
end