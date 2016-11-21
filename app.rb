require 'rubygems'
require 'bundler'
Bundler.require
require 'sinatra'
require 'curb'

class LightHouseApi < Sinatra::Base
  before do
    content_type :json
    response.headers['Access-Control-Allow-Origin'] = "*"
  end
  
  get '/tickets.json' do
    request_params = URI::encode(params[:q])

    # This parametrization is horrible and I deserve to be punished.
    baseurl = "https://3months.lighthouseapp.com/tickets.json?q=#{request_params}"
    http = Curl.get(baseurl) do | http |
      http.headers["X-LighthouseToken"] = ENV['LIGHTHOUSE_API_TOKEN']
      http.headers["Content-Type"] = "application/json"
    end
    #I'm sure there is a better way to render this.
    http.body_str
  end

end
