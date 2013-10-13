class ApiClient
  require 'singleton'
  include Singleton

  def get_offers(user_id, pub0=nil, page=nil)
    params = prepare_params uid: user_id, pub0: pub0, page: page
    params.merge!({hashkey: generate_hash_key(params)})

    handle_exception 'get_offers', params do
      connection.get '/feed/v1/offers.json' do |req|
        req.headers['Content-Type'] = 'application/json'
        req.params = params
      end
    end
  end

  private

  def handle_exception(method, params, &block)
    yield
  rescue Faraday::Error::ResourceNotFound, Faraday::Error::ClientError, Faraday::Error::ConnectionFailed => e
    log_error(e, method, params)
    return e.response
  end

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

  def prepare_params(opts)
    params = {
      appid: ApiSettings[:appid],
      device_id: ApiSecret[:device_id],
      ip: ApiSettings[:ip],
      locale: ApiSettings[:locale],
      offer_types: ApiSettings[:offer_types],
      timestamp: Time.now.getutc.to_i,
    }
    params.merge!(opts)
    params.reject! {|k,v| v.nil?}

    exit_params = {}
    params.sort.each do |p|
      exit_params[p[0]] = p[1]
    end
    return exit_params
  end

  def generate_hash_key(params)
    Digest::SHA1.hexdigest(params.to_query + "&" + ApiSecret[:api_key])
  end

  def log_error(e, method, params)
    Rails.logger.error "\nApiClient encountered a:\n" +
    "--- #{e.to_s}\n" +
    "while performing\n" +
    "--- #{method}\n" +
    "with the following params:\n" +
    "#{params.to_yaml}\n"
  end
end