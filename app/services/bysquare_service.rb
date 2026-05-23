require 'net/http'
require 'uri'
require 'json'

class BysquareService

  def self.decode(payload)
    uri = URI(ENV['BYSQUARE_URL'])

    response = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
      request = Net::HTTP::Post.new(uri)
      request['Authorization'] = ENV['BYSQUARE_API_KEY']
      request['Content-Type'] = 'application/json'

      request.body = {payload: payload, format: "invoice" }.to_json

      http.request(request)
    end

    JSON.parse(response.body)
  end
end