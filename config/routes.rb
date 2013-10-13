Sponsorpay::Application.routes.draw do

  root :to => 'api_client#show'

  get 'api_client/get_offers' => 'api_client#get_offers'

end
