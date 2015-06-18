class Lottery
  def initialize(size)
    @prizeCount = size
    @members = []
  end

  def add(name,weight)
    if isInMembers(name)
      p "Exist " + name
      return
    end
    @members.push(Member.new(name,weight))
  end

  def getMembers
    @members.map {|member| member.name}
  end

  def getWinners
    return [] if @prizeCount === 0 || @members.length === 0
    return getMembers if @prizeCount >= @members.length
    return decideWinners
  end

  def decideWinners
    winners = []
    membersWithWeight = getMembersWithWeight
    @prizeCount.times {
      luckyName = membersWithWeight[rand(0..membersWithWeight.length - 1)]
      winners.push(luckyName)
      membersWithWeight.reject! {|memberName| memberName === luckyName}
    }
    return winners
  end

  def isInMembers(name)
    names = getMembers
    names.include?(name)
  end

  def getMembersWithWeight
    membersWithWeight = []
    @members.each {|member|member.weight.times {membersWithWeight.push(member.name)}}
    return membersWithWeight
  end
end

class Member
  attr_reader :name
  attr_reader :weight

  def initialize(n, w)
    @name = n
    @weight = w
  end
end
