# Shoes.setup do
#   source "http://rubygems.org"
#   gem "rubybooty"
# end
require_relative 'rubybooty'

include Rubybooty
Shoes.app do
  @entrants = {}
  banner "RubyBooty"
  stack width: "70%" do
    flow do
      para "Entrants name: "
      @name = edit_line
    end
    flow do
      para "Number of entries: "
      @entries = edit_line(width: 50)
    end
    button "Add" do
      @entrants[@name.text] = @entries.text.to_i
      @name_list.append do
        para "#{@name.text} is in for $#{@entrants[@name.text]}"
      end
      @sum = @entrants.values.inject(0, &:+)
      @total.text = "Total: $#{@sum}"
      @name.text = ""
      @entries.text = ""
    end
  end
  stack width: "30%" do
    stack do
      background white
      @name_list = stack
    end
    stack do
      @total = para "Total: $0"
    end
  end
  stack width: "100%" do
    button "Run now!" do
      winner = Rubybooty.raffle_sort(@entrants)
      if winner
        @results.append do
          title "#{winner} is the winner of $#{(@sum / 2.0).ceil}! AARRR!"
        end
      else
        alert "No winner. :("
      end
    end
    @results = stack
  end
end