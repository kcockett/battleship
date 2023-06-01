module Sayable

  def self.say(sentence)
    require 'pry'; binding.pry
    beats = list.to_string
    rate = 80
    voice = "Fred"
    `say -r #{rate} -v #{voice} #{sentence}`
  end
end