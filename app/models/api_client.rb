class ApiClient
  require 'singleton'
  include Singleton

  def get_offers(user_id, pub0=nil, page=nil)
    params = {
      appid: ApiSettings[:appid],
      device_id: ApiSecret[:device_id],
      ip: ApiSettings[:ip],
      locale: ApiSettings[:locale],
      offer_types: ApiSettings[:offer_types],
      page: page,
      pub0: pub0,
      timestamp: Time.now.getutc.to_i,
      uid: user_id
    }
    params.delete(:page) unless page
    params.delete(:pub0) unless pub0

    params.merge!({hashkey: generate_hash_key(params)})

    connection.get '/feed/v1/offers.json' do |req|
      req.headers['Content-Type'] = 'application/json'
      req.params = params
    end
  end

  private

  def connection
    @connection ||= Faraday.new(:url => ApiSettings[:api_url]) do |faraday|
      faraday.use FaradayMiddleware::EncodeJson
      faraday.use FaradayMiddleware::ParseJson
      faraday.use Faraday::Request::UrlEncoded
      faraday.use Faraday::Response::RaiseError
      # faraday.use Faraday::Response::Logger if (Rails.env.development? || Rails.env.test?)
      faraday.response :logger
      faraday.use Faraday::Adapter::NetHttp
    end
  end

  def generate_hash_key(params)
    Digest::SHA1.hexdigest(params.to_query + "&" + ApiSecret[:api_key])
  end
end