require_relative './lib/lottery'
lottery = Lottery.new(2)
lottery.add("A1",1)
lottery.add("A3",3)
lottery.add("A5",5)
lottery.add("A10",10)
p lottery.winners
