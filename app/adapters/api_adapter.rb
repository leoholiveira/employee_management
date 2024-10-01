require "httparty"

class ApiAdapter
  include HTTParty
  base_uri "https://beta.01cxhdz3a8jnmapv.com/api/v1/assignment"

  def initialize
    @token = fetch_token
  end

  def fetch_employees
    response = self.class.get("/employee/list", headers: auth_header)
    JSON.parse(response.body)
  end

  private

  def fetch_token
    response = self.class.post("/token/", body: {
      grant_type: "password",
      client_id: "6779ef20e75817b79605",
      client_secret: "3e0f85f44b9ffbc87e90acf40d482602",
      username: "hiring",
      password: "tmtg"
    })
    JSON.parse(response.body)["access_token"]
  end

  def auth_header
    { "Authorization" => "Bearer #{@token}" }
  end
end
