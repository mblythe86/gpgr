require File.dirname(__FILE__) + '/test_helper.rb'

class TestKeyManagementFunctionality < Test::Unit::TestCase

  
  def test_installed_public_keys
    setup_for_key_tests
    before = Gpgr::Keys.installed_public_keys.nitems
    Gpgr::Keys.import @john_key
    Gpgr::Keys.import @mark_key
    assert_equal before + 2, Gpgr::Keys.installed_public_keys.nitems
    teardown_for_key_tests
  end
  
  def test_import_keys_method_adds_keys
    setup_for_key_tests
    assert_equal false, Gpgr::Keys.installed_public_keys.include?('john@example.com')
    assert_equal false, Gpgr::Keys.installed_public_keys.include?('mark@example.com')
    Gpgr::Keys.import @john_key
    Gpgr::Keys.import @mark_key
    assert_equal true, Gpgr::Keys.installed_public_keys.include?('john@example.com')
    assert_equal true, Gpgr::Keys.installed_public_keys.include?('mark@example.com')
    teardown_for_key_tests
  end

  def test_import_all_keys_at_a_path
    path = File.dirname(__FILE__) + '/test_keys'
    before = Gpgr::Keys.installed_public_keys.nitems
    Gpgr::Keys.import_keys_at(path)
    assert_equal before + 3, Gpgr::Keys.installed_public_keys.nitems
    cleanup_batch_keys
  end
  
  def test_import_all_keys_at_path_with_non_key_files
    path = File.dirname(__FILE__) + '/test_keys_with_non_key_files'
    before = Gpgr::Keys.installed_public_keys.nitems
    Gpgr::Keys.import_keys_at(path)
    assert_equal before + 3, Gpgr::Keys.installed_public_keys.nitems
    cleanup_batch_keys
  end
  
  def setup_for_key_tests
    puts "=>\tGenerating keys for test - please wait"
    @john_key = generate_key_for('john@example.com','John Test')
    @mark_key = generate_key_for('mark@example.com','Mark Test')
    puts "=>\tDone!"
  end
  
  def teardown_for_key_tests
    remove_installed_key 'john@example.com'
    remove_installed_key 'mark@example.com'
  end

end
