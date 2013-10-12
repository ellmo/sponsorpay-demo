def api_response_double(type=:no_content)
  begin
    yaml = YAML.load(File.read("spec/fixtures/api_response/#{type.to_s}.yml")).with_indifferent_access
  rescue Errno::ENOENT
    raise MissingFixture.new("No fixture file found for: spec/fixtures/api_response/#{type.to_s}.yml")
  end
  mocked_response = double('api_response')
  mocked_response.stubs(:body).returns yaml[:body]
  mocked_response.stubs(:status).returns yaml[:status]
  mocked_response.stubs(:headers).returns yaml[:headers]
  return mocked_response
end

def stub_api_client
  client = ApiClient.instance
  client.stubs(:get_offers).returns api_response_double
end