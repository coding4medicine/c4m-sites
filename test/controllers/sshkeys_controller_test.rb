require 'test_helper'

class SshkeysControllerTest < ActionDispatch::IntegrationTest
  setup do
    @sshkey = sshkeys(:one)
  end

  test "should get index" do
    get sshkeys_url
    assert_response :success
  end

  test "should get new" do
    get new_sshkey_url
    assert_response :success
  end

  test "should create sshkey" do
    assert_difference('Sshkey.count') do
      post sshkeys_url, params: { sshkey: { key: @sshkey.key, user_id: @sshkey.user_id } }
    end

    assert_redirected_to sshkey_url(Sshkey.last)
  end

  test "should show sshkey" do
    get sshkey_url(@sshkey)
    assert_response :success
  end

  test "should get edit" do
    get edit_sshkey_url(@sshkey)
    assert_response :success
  end

  test "should update sshkey" do
    patch sshkey_url(@sshkey), params: { sshkey: { key: @sshkey.key, user_id: @sshkey.user_id } }
    assert_redirected_to sshkey_url(@sshkey)
  end

  test "should destroy sshkey" do
    assert_difference('Sshkey.count', -1) do
      delete sshkey_url(@sshkey)
    end

    assert_redirected_to sshkeys_url
  end
end
