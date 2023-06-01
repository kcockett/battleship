module Sayable

  def say(message)
    rate = 80
    voice = "Fred"
    `say -r #{rate} -v #{voice} #{message}`
  end
end