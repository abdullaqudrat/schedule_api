require 'rails_helper'

describe 'Schedule API' do
  let(:name) { "dentist" }
    it 'can create a appointment' do

    post "/api/v1/schedule?name=planner"

    expect(response).to be_successful

    post "/api/v1/schedule/planner/appointment?name=#{name}"

    json_response = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(json_response).to be_a(Hash)
    expect(json_response).to have_key(:message)
    expect(json_response[:message]).to eq("Added dentist to planner")
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
end