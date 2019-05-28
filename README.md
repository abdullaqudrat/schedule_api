# Schedule API

Schedule API is a simple simple schedule management tool built in Ruby on Rails. This API manages multiple schedules, adding and removing appointments. It is a RESTful API that uses POROs and model-caching for in memory storage. It implements Rails' **ActiveSupport::Cache::MemoryStore** to store scheduling and appointment information, instead of a traditional database, since it is built into Rails and its easy to use, and its storing small amounts of cached data (<20MB). This strategy will be revisited if the app was ever to scale up.

### Technologies Used

- Rails 5.2.3
- Ruby 2.4.1

### System dependencies

* 'rspec-rails'
* 'pry'
* 'shoulda-matchers'
* 'simplecov'

### Cloning this repo

```
git clone https://github.com/abdullaqudrat/schedule_api.git
cd schedule_api
bundle
```
### Testing

This API was driven by TDD and uses SimpleCov to measure test coverage.

 * Testing tools used:
  - RSpec
  - Shoulda-Matchers
  
* Run `rails s` from the command line of the root directory to open a local server for api requests
* Run `rspec` from the command line of the root directory to run test suite

--------

## API Endpoints

#### Request Parameters

| parameter       | description                           |
|-----------------|---------------------------------------|
| name-parameter  | spaces must be hyphens, case-sensitive|
| time-param  | integer, start time must be less than the end time, appointments for a given schedule cannot overlap|

---

#### Schedule Endpoints

* Create a new schedule `POST /api/v1/schedule?name=name-parameter`
* Get an existing schedule `GET /api/v1/schedule/name-parameter`
* Delete an existing schedule `DELETE /api/v1/schedule/name-parameter`

---

#### Appointment Endpoints

* Create a new appointment `POST /api/v1/schedule/name-parameter/appointment?name=name-parameter&start_time=time-param&end_time=time-param`
* Get an existing appointment `GET /api/v1/schedule/name-parameter/appointment/name-parameter`
* Delete an existing appointment `DELETE /api/v1/schedule/name-parameter/appointment/name-parameter`

---

### Example Requests URL for schedules

**POST `/api/v1/schedule?name=George's-Weekly-planner`**

- This endpoint will return a message if a successfully created and stored.
```json
{
  "message": "Schedule 'George's Weekly planner' created"
}
```
or
```json
{
  "message": "error"
}
```
if failed

**GET `/api/v1/schedule/George's-Weekly-planner`**

- This endpoint will return the schedule object if it exists.
```json
{
  "name": "George's Weekly planner",
  "appointments": []
}
```
or
```json
{
  "message": "error"
}
```
if it doesn't

**DELETE `/api/v1/schedule/George's-Weekly-planner`**

- This endpoint will return the message if schedule object exists and it is deleted from memory.
```json
{
  "message": "Schedule deleted"
}
```
or
```json
{
  "message": "error"
}
```
if it doesn't

---

### Example Requests URL for appointments

**POST `/api/v1/schedule/George's-Weekly-planner/appointment?name=basketball-with-friends&start_time=7&end_time=8`**

- This endpoint will return a message if a successfully created and stored.
```json
{
  "message": "Added basketball with friends to George's Weekly planner"
}
```
or
```json
{
  "message": "error"
}
```
if failed

**GET `/api/v1/schedule/George's-Weekly-planner/appointment/basketball-with-friends`**

- This endpoint will return the appointment object if it exists.
```json
{
  "name": "basketball with friends",
  "start_time": "7",
  "end_time": "8",
}
```
or
```json
{
  "message": "error"
}
```
if it doesn't

**DELETE `/api/v1/schedule/George's-Weekly-planner/appointment/basketball-with-friends`**

- This endpoint will return the message if appointment object exists and it is deleted from memory.
```json
{
  "message": "Deleted appointment"
}
```
or
```json
{
  "message": "error"
}
```
if it doesn't
