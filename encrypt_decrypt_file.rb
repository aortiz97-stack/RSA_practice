require_relative "./rsa_algorithm.rb"

def encrypt(file_name, encrypt_key)
    encrypt_file = File.open("encrypted_#{file_name}", "w")

    File.foreach(file_name) do |line|
        line.each_char do |char|
            ascii_char = char.ord
            encrypted_char = (ascii_char.to_i ** encrypt_key[0]) % encrypt_key[1]
            encrypt_file.write(encrypted_char.to_s+"\n")
        end
    end

    encrypt_file.close
end

def decrypt(file_name, decrypt_key)
    decrypt_file = File.open("decrypted_#{file_name.split("encrypted_")[1]}", "w")

    File.foreach(file_name) do |line|
        ascii = (line.chomp.to_i ** decrypt_key[0]) % decrypt_key[1]
        decrypt_file.write(ascii.chr)
    end

    decrypt_file.close
end
