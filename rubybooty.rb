module Rubybooty
  
  def self.raffle_sort(entrants)
    [].tap do |entries|
      entrants.each { |k,v| v.times { entries << k }}
    end.shuffle!.first
  end
end