require 'spec_helper'

describe ApplicationsController do


  describe "#submit" do
    before(:each) do
      @application = FactoryGirl.create(:application)
      @candidate = FactoryGirl.create(:candidate)
      @candidate.application = @application
      @app = @candidate.application
      controller.stub(:current_user).and_return(@candidate)

    end

    it "should change the status of a users application to complete" do
      post 'submit'



      @candidate.reload.application.complete.should eq true
    end

    it "should flash notice if the submission does not work" do
      post 'submit'


      flash[:notice].should be_nil
      @candidate.reload.application.complete.should eq true
    end

    it "should redirect to user page" do
      post 'submit'



      redirect_to candidate_path(@candidate)
    end
  end

  describe "#edit" do

    it 'should render the edit page' do
      @candidate = FactoryGirl.create(:candidate)
      @app = @candidate.application
      controller.stub(:current_application).and_return(@candidate.application)

      get :edit, candidate_id: @candidate.id, id: @app.id

      response.should render_template(:edit)
    end

  end


  describe "#update" do

    it 'should update the application' do

      @myresponse = Response.create!(body: "this is a response")

      @application = FactoryGirl.create(:application)
      @candidate = FactoryGirl.create(:candidate)
      @candidate.application = @application
      @app = @candidate.application
      controller.stub(:current_user).and_return(@candidate)
      controller.stub(:current_application).and_return(@app)

      patch :update, candidate_id: @candidate.id, id: @application.id, application: {"responses_attributes"=>{"0"=>{"body"=>"Hello, Worldaslkdjfjkldsjhadslf", "id"=> @myresponse.id}}}

      @myresponse.reload.body.should eq "Hello, Worldaslkdjfjkldsjhadslf"
      response.should redirect_to(edit_candidate_application_path(@candidate, @app))
    end

  end

end




