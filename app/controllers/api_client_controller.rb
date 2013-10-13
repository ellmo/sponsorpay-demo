class ApiClientController < ApplicationController
  def show; end

  def get_offers
    @client ||= ApiClient.instance
    @client.get_offers(params[:uid], params[:pub0], params[:page])
    binding.pry
  end
end