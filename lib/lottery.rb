class Lottery
  attr_reader :prize_count

  def initialize size
    @prize_count = size
    @members = []
  end

  def add(name,weight)
    return if names.include?(name)
    @members << Member.new(name,weight)
  end

  def names
    @members.map {|member| member.name }
  end

  def winners
    return [] if @prize_count === 0 || @members.length === 0
    return names if @prize_count >= @members.length
    return decide_winners
  end

  private

  def decide_winners
    winners_names = []
    target_names = weighted_names
    @prize_count.times do
      lucky_name = target_names.sample
      winners_names << lucky_name
      target_names.reject! {|name| name === lucky_name }
    end
    winners_names
  end

  def weighted_names
    @members.flat_map {|member|Array.new(member.weight,member.name) }
  end
end

class Member
  attr_reader :name, :weight

  def initialize(n, w)
    @name = n
    @weight = w
  end
end
