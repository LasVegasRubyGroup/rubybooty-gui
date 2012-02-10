module Rubybooty
  
  def self.raffle_sort(entrants)
    entries = []
    entrants.each { |k,v| v.times { entries << k }}
    rand(100).times { entries.shuffle! }
    winner = entries.first
  end
end