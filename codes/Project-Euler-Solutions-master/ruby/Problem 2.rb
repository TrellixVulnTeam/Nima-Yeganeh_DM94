#!/usr/bin/env ruby

=begin official problem
http://projecteuler.net/index.php?section=problems&id=2

Each new term in the Fibonacci sequence is generated by adding the previous two terms. By starting with 1 and 2, the first 10 terms will be:

1, 2, 3, 5, 8, 13, 21, 34, 55, 89, ...

Find the sum of all the even-valued terms in the sequence which do not exceed four million.
=end

def fibUpTo(max)
  one = 1
  two = 2
  sum = 2
  
  while (one + two < max) do
    three = one + two
    sum += three if three%2==0
    one = two
    two = three
  end
  sum
end

puts fibUpTo(4000000)