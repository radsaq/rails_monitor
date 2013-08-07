require 'spec_helper'
require File.join(File.dirname(__FILE__), '..', 'examples', 'example_monitoring_controller')

describe RailsMonitor::Monitoring do
  before(:each) do
    @controller = ExampleMonitoringController.new
    @request = ActionController::TestRequest.new
    @response = ActionController::TestResponse.new
    @controller.request = @request
    @controller.response = @response
  end

  it 'should create an index method' do
    @controller.should respond_to(:index)
  end

  it 'should create a method for each status' do
    @controller.should respond_to(:test_status_one)
    @controller.should respond_to(:test_status_two)
    @controller.should respond_to(:test_status_three)
    @controller.should respond_to(:test_status_four)
  end

  it 'should render a numeric endpoint' do
    @controller.test_status_one
    @response.body.should == 'OK: 10'
    @response.headers['Content-type'].should == 'text/plain'
  end

  it 'should warn for a numeric endpoint' do
    @controller.test_warn_numeric
    @response.body.should == 'WARN: 15'
    @response.headers['Content-type'].should == 'text/plain'
  end

  it 'should error for a numeric endpoint' do
    @controller.test_error_numeric
    @response.body.should == 'ERROR: 25'
    @response.headers['Content-type'].should == 'text/plain'
  end

  it 'should error for a boolean' do
    @controller.test_error_boolean
    @response.body.should == 'ERROR: false'
    @response.headers['Content-type'].should == 'text/plain'
  end

  it 'should allow a warn threshold to be specified in params' do
    @request.params['warn_threshold'] = '5'
    @controller.test_status_one
    @response.body.should == 'WARN: 10'
  end

  it 'should allow an error threshold to be specified in params' do
    @request.params['error_threshold'] = '5'
    @controller.test_status_one
    @response.body.should == 'ERROR: 10'
  end
end

