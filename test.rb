require_relative "./encrypt_decrypt_file.rb"
rsa = RSA_Keys.new
encrypt_key = rsa.e

encrypt("secret.txt", encrypt_key)