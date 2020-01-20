require_relative "./rsa_algorithm.rb"

def encrypt(file_name, encrypt_key)
    encrypt_file = File.open("encrypted_#{file_name}", "w")

    File.foreach(file_name) do |line|
        line.each_char do |char|
            ascii_char = char.ord
            encrypted_char = (ascii_char.to_i ** encrypt_key[0]) % encrypt_key[1]
            encrypt_file.write(encrypted_char)
        end
    end

    encrypt_file.close

end
