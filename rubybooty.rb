module Rubybooty
  class Array
    def shuffle!
      size.downto(1) { |n| push delete_at(rand(n)) }
      self
    end
  end
  
  def self.raffle_sort(entrants)
    entries = []
    entrants.each { |k,v| v.times { entries << k }}
    winner = entries.shuffle!.first
  end
end