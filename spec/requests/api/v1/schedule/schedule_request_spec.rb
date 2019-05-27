require 'rails_helper'

describe 'Schedule API' do
  it 'can create a schedule' do
    name = "Abdulla's Planner"

    post "/api/v1/schedule?name=#{name}"

    json_response = JSON.parse(response.body, symbolize_names: true)
    expect(response).to be_successful
    expect(json_response).to be_a(Hash)
    expect(json_response).to have_key(:message)
    expect(json_response[:message]).to eq("Schedule 'Abdulla's Planner' created")
  end
  it 'fails to create a schedule with no params' do
    name = "Abdulla's Planner"

    post "/api/v1/schedule"

    json_response = JSON.parse(response.body, symbolize_names: true)
    expect(response).to be_successful
    expect(json_response).to be_a(Hash)
    expect(json_response).to have_key(:message)
    expect(json_response[:message]).to eq("error")
  end
end