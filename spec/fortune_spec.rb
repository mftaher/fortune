require_relative './spec_helper'

describe 'Fortune' do
  def app
    FortuneApp
  end
  let!(:base_url){'/fortune'}

  context 'API route' do
    it '/fortune/ returns random single fortune' do
      get "/"
      last_response.status.should == 200
    end

    it '/fortune/ returns plain text fortune' do
      get "/"
      last_response.content_type.should =~ /text\/plain/
    end

    it '/fortune/ returns json type fortune' do
      get "/", '', 'Content-Type' => 'application/json'
      last_response.content_type.should =~ /application\/json/
    end

    it '/fortune/0 returns short single fortune' do
      get "/0"
      last_response.status.should == 200
    end
    it '/fortune/1 returns long single fortune' do
      get "/1"
      last_response.status.should == 200
    end

    it '/fortune/0/0 returns short single non-offensive fortune' do
      get "/0/0"
      last_response.status.should == 200
    end
    it '/fortune/0/1 returns short single offensive fortune' do
      get "/0/1"
      last_response.status.should == 200
    end
    it '/fortune/1/0 returns long single non-offensive fortune' do
      get "/1/0"
      last_response.status.should == 200
    end

    it '/fortune/1/1 returns long single offensive fortune' do
      get "/1/1"
      last_response.status.should == 200
    end


  end
end