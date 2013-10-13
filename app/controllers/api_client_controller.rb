class ApiClientController < ApplicationController
  def show; end

  def get_offers
    respond_to do |format|
      format.js do
        @client ||= ApiClient.instance
        params.reject! {|k,v| v.blank?}
        response = @client.get_offers(params[:uid], params[:pub0], params[:page])
        render json: response[:body] || response.body
      end
    end
  end
end