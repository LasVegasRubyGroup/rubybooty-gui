require File.join(Dir.pwd, 'rubybooty')

include Rubybooty
Shoes.app(title: 'LVRUG Rubybooty', width: 760) do
  @entrants = {}
  @checks = {}
  @names_list = []
  @para_list = []
  i = 0
  flow width: "100%", margin: ["0px", "0px", "0px", "10%"] do
    background '#8D0000'..'#000000', curve: 12
    banner "RubyBooty", align: "center", stroke: white
  end
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
          @title = para
          @title.style(font: "Arial 40px", stroke: red)
          @title.text = "and the winner is"
          @anim = animate(30) do |a|
            @title.text += "."
            if a >= 40
              @title.text = "#{winner} for $#{(@sum / 2.0).ceil}! AARRR!"
              @anim.stop
            end
          end
        end
      else
        alert "No winner. :("
      end
    end
    @results = stack
  end
  flow width: "100%", margin: ["0px", "10%", "0px", "0px"] do
    background '#CACACA'
    stack top: 0, left: ((self.width - 120) / 2) do
      image File.join(Dir.pwd, 'assets', 'lvrug.png'), width: 120, height: 63, click: "http://www.meetup.com/las-vegas-ruby-on-rails/"
    end
  end
end