require 'bsearch'
# This file contains the methods necessary for creating the public and private keys for encryption and decryption, respectively, using RSA

# Generates large random integers for generating p and q.
class RSA_Keys
    attr_reader :p, :q
    MIN = 10
    MAX = 100
    def initialize
        @p = self.generate_prime_integers
        @q = self.generate_prime_integers
    end

    def generate_prime_integers
        rand_num = rand(MIN...MAX)
        already_in = []
        while !prime?(rand_num)
            already_in << rand_num
            while already_in.include?(rand_num)
                rand_num = rand(MIN...MAX)
            end
        end
        rand_num
    end

    def prime?(n)
        return false if n < 2
        (2...n).none? {|factor| n % factor == 0}
    end

    def modulus
        @p * @q
    end

    def totient
        (@p-1) * (@q-1)
    end

    def factors(n) #only using positive factors here, excluding 1
        factors = []
        return factors if n < 2
        (2..n).each do |factor|
            factors << factor if n % factor == 0
        end

        factors
    end

    def co_prime?(a, b)
        return false if a == 1 || b == 1
        a_factors = factors(a)
        b_factors = factors(b)

        if a_factors.length > b_factors.length
            biggest = a_factors
            smallest = b_factors        
        else
            biggest = b_factors
            smallest = a_factors  
        end

        smallest.none?{|small_f| biggest.include?(small_f) }
    end

    def e
        (2...self.totient).each{|int| return [int,self.modulus] if co_prime?(int, self.totient) && co_prime?(int, self.modulus)}
    end

    def find_x #helper method for finding the decryption key
        x = 1
        while (1 + (x * self.totient)) % self.e[0] != 0
            x += 1
        end 
        x
    end

    def d
        x = find_x
        [(1 + (x * self.totient)) / self.e[0], self.modulus]
    end
end


