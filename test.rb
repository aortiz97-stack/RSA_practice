require_relative "./encrypt_decrypt_file.rb"
rsa = RSA_Keys.new
encrypt_key = rsa.e
decrypt_key = rsa.d

p rsa.p
p rsa.q
p encrypt_key
p decrypt_key

encrypt("secret.txt", encrypt_key)
decrypt("encrypted_secret.txt", decrypt_key)