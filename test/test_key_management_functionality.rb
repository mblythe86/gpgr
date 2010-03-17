require File.dirname(__FILE__) + '/test_helper.rb'

class TestKeyManagementFunctionality < Test::Unit::TestCase

  def setup
    @john_key = generate_key_for('john@example.com','John Test')
    @mark_key = generate_key_for('mark@example.com','Mark Test')
  end
  
  def teardown
    remove_installed_key 'john@example.com'
    remove_installed_key 'mark@example.com'
  end
  
  def test_import_keys_method_adds_keys
    assert_equal false, Gpgr::Keys.installed_public_keys.include?('john@example.com')
    assert_equal false, Gpgr::Keys.installed_public_keys.include?('mark@example.com')
    Gpgr::Keys.import @john_key
    Gpgr::Keys.import @mark_key
    assert_equal true, Gpgr::Keys.installed_public_keys.include?('john@example.com')
    assert_equal true, Gpgr::Keys.installed_public_keys.include?('mark@example.com')
  end

end
