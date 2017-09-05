require 'test_helper'

class DonationsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get donations_show_url
    assert_response :success
  end

end
