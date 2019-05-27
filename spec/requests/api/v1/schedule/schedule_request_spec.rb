require 'rails_helper'

describe 'Schedule API' do
  it 'can create a schedule' do
    name = "Abdulla's Planner"

    get "/api/v1/schedule/create?name=#{name}"

    json_response = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
  end
end