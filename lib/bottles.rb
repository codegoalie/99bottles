# Bottles is responsible for singing the song 99 bottles of beer
class Bottles
  def verse(which)
    count = BottleCount.new(which)
    "#{capitalize(count.bottles)} on the wall, #{count.bottles}.\n"\
    "#{count.take_one_down || count.go_to_store}, #{count.next.bottles} on the wall.\n"
  end

  def verses(start, stop)
    output = []
    (stop..start).reverse_each do |round|
      output << verse(round)
    end
    output.join("\n")
  end

  def song
    verses(99, 0)
  end

  private

  def capitalize(string)
    string[0] = string[0].upcase
    string
  end

  # BottleCount is an internal class to manage the parts of the song
  # which change based on the count of bottles
  class BottleCount
    attr_reader :count

    def initialize(count)
      @count = count
    end

    def bottles
      case count
      when 1
        '1 bottle of beer'
      when 0
        'no more bottles of beer'
      else
        "#{count} bottles of beer"
      end
    end

    def take_one_down
      case count
      when 1
        'Take it down and pass it around'
      when 0
        nil
      else
        'Take one down and pass it around'
      end
    end

    def go_to_store
      'Go to the store and buy some more'
    end

    def next
      BottleCount.new((count - 1) % 100)
    end
  end
end
