require File.join(Dir.pwd, 'rubybooty')

include Rubybooty
Shoes.app(title: 'LVRUG Rubybooty', width: 760) do
  @entrants = {}
  @checks = {}
  @names_list = []
  @para_list = []
  i = 0
  
  banner "RubyBooty"
  stack width: "60%" do
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
        @para_list.push << flow do
          para "#{@name.text} is in for $#{@entrants[@name.text]}"
          inscription "Delete?"
          @check = check
        end
        @names_list << @name.text
        @check.click do |c|
          if c.checked? and confirm('Are you sure?')
            val = @checks.values_at(c).first
            @entrants.delete_if { |k,v| k.eql?(@names_list[val]) }
            @para_list[val].remove
            @sum = @entrants.values.inject(0, &:+)
            @total.text = "Total: $#{@sum}"
          end
          c.checked = false
        end
        @checks[@check] = i
        i += 1
      end
      @sum = @entrants.values.inject(0, &:+)
      @total.text = "Total: $#{@sum}"
      @name.text = ""
      @entries.text = ""
    end
  end
  stack width: "40%" do
    stack do
      background white
      border black, strokewidth: 1
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