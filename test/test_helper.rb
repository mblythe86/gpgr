require 'test/unit'

# Figure out the root relative to where this file is
#
GPGR_ROOT = File.expand_path(File.dirname(__FILE__) + '/../lib')

# Include the gpgr library
#
require GPGR_ROOT + '/gpgr.rb'



# Helper methods for the tests.
#

def generate_key_for(email, name)
  file_path = "/tmp/gpgr_testing_#{Time.now.to_i}"
  params = <<-PGP
Key-Type: DSA
Key-Length: 1024
Subkey-Type: ELG-E
Subkey-Length: 1024
Name-Real: #{name}
Name-Comment: with stupid passphrase
Name-Email: #{email}
Expire-Date: 0
Passphrase: abc
%pubring #{file_path}.pub
%secring #{file_path}.sec
%commit
  PGP
  `echo '#{params}' | gpg --batch --gen-key -a`
  if File.exists?(file_path + '.pub')
    return file_path + '.pub'
  else
    raise "ARRGH"
  end
end

def remove_installed_key(email)
  system "gpg --delete-key --yes --batch #{email}"
end