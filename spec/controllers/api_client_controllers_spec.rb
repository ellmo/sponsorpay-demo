require 'spec_helper'

describe ApiClientController do

  describe "GET 'get_offers'" do

    context 'only uid is given' do
      let(:params) do
        { uid: 'player1',
          format: :js }
      end

      before do
        stub_api_client
        get :get_offers, params
      end

      it 'should return fixtured response' do
        response.body.should_not be_nil
        response.status.should_not be_nil
        response.headers.should_not be_nil

        json = JSON(response.body).with_indifferent_access

        json[:code].should eq 'NO_CONTENT'
        json[:count].should eq 0
        json[:pages].should eq 0
      end
    end

    context 'uid and page are given' do
      let(:params) do
        { uid: 'player1',
          page: 2,
          format: :js }
      end

      before do
        stub_api_client
        get :get_offers, params
      end

      it 'should return fixtured response' do
        response.body.should_not be_nil
        response.status.should_not be_nil
        response.headers.should_not be_nil

        json = JSON(response.body).with_indifferent_access

        json[:code].should eq 'NO_CONTENT'
        json[:count].should eq 0
        json[:pages].should eq 0
      end
    end

    context 'uid and pub0 are given' do
      let(:params) do
        { uid: 'player1',
          pub0: 'campaign0',
          format: :js }
      end

      before do
        stub_api_client
        get :get_offers, params
      end

      it 'should return fixtured response' do
        response.body.should_not be_nil
        response.status.should_not be_nil
        response.headers.should_not be_nil

        json = JSON(response.body).with_indifferent_access

        json[:code].should eq 'NO_CONTENT'
        json[:count].should eq 0
        json[:pages].should eq 0
      end
    end

    context 'uid, pub0 and page are given' do
      let(:params) do
        { uid: 'player1',
          pub0: 'campaign0',
          page: 1,
          format: :js }
      end

      before do
        stub_api_client
        get :get_offers, params
      end

      it 'should return fixtured response' do
        response.body.should_not be_nil
        response.status.should_not be_nil
        response.headers.should_not be_nil

        json = JSON(response.body).with_indifferent_access

        json[:code].should eq 'NO_CONTENT'
        json[:count].should eq 0
        json[:pages].should eq 0
      end
    end
  end
end