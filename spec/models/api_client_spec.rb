require 'spec_helper'

describe ApiClient do
  let(:apic) { ApiClient.instance }

  context 'private methods' do
    context 'when sending only uid param' do
      it "properly hashes the params" do
        sorted_params = apic.send :prepare_params,
          uid: 'player1',
          ps_time: 1312211903,
          timestamp: 1312553361
        hashkey = apic.send :generate_hash_key, sorted_params
        hashkey.should eq '7df358e0b82dcb2c7adcd706b60a1d2d96018140'
      end
    end

    context 'when sending additional page param' do
      it "properly hashes the params" do
        sorted_params = apic.send :prepare_params,
          page: 2,
          ps_time: 1312211903,
          timestamp: 1312553361,
          uid: 'player1'
        hashkey = apic.send :generate_hash_key, sorted_params
        hashkey.should eq '8a5d683ed1e698421aefa4e5972367c964dbbb59'
      end
    end

    context 'when sending additional pub0 param' do
      it "properly hashes the params" do
        sorted_params = apic.send :prepare_params,
          uid: 'player1',
          pub0: 'campaign2',
          ps_time: 1312211903,
          timestamp: 1312553361
        hashkey = apic.send :generate_hash_key, sorted_params
        hashkey.should eq 'd556f4c0ba1b707d5c6e7e46d7c74fae01a87026'
      end
    end

    context 'when sending both additional params' do
      it "properly hashes the params" do
        sorted_params = apic.send :prepare_params,
          uid: 'player1',
          pub0: 'campaign2',
          ps_time: 1312211903,
          page: 2,
          timestamp: 1312553361
        hashkey = apic.send :generate_hash_key, sorted_params
        hashkey.should eq '3dcd956d970da49978af581c651368a35431ff1c'
      end
    end
  end

  context 'get_offers' do

    before do
      stub_api_client
    end

    context 'when getting offers' do
      it "returns the api response double" do
        response = apic.get_offers('player1')
        response.body.should_not be_nil
        response.status.should_not be_nil
        response.headers.should_not be_nil

        response.body[:code].should eq 'NO_CONTENT'
        response.body[:count].should eq 0
        response.body[:pages].should eq 0
      end
    end
  end
end
