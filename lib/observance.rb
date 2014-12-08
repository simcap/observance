require 'observance/version'

module Observance

  Observation = Struct.new(:object, :index, :factor) do
    include Comparable

    def <=>(other)
      return nil unless other.is_a? self.class
      if other.factor == self.factor
        self.index <=> other.index
      else
        other.factor <=> self.factor
      end
    end
  end

  def self.run(*observations)
    obs = if observations.first.is_a? Array
            wrapped_in_hashes(observations)
          elsif observations.first.respond_to? :to_h
            observations
          else
            raise "Observations need to be Array or respond to 'to_h'"
          end
    obs.each_with_index.map do |c, index|
      factor = (obs.inject(0) do |acc, o|
        acc = acc + c.similarity_to(o)
      end).fdiv(obs.size)
      Observation.new(observations[index], index, factor.round(4))
    end.sort
  end

  private

  def self.wrapped_in_hashes(observations)
    observations.map do |o| 
      Hash[(0...o.size).zip(o)]
    end
  end
end

class Hash
  # Returns a factor f between 0 and 1 that indicates
  # the similarity factor of self to other
  #
  # Calculates the number of keys with the same values
  # then divide the result by the number of keys
  def similarity_to(other)
    smaller_one, bigger_one = [self, other].sort_by(&:size)
    diff_size = bigger_one.size - smaller_one.size

    ratio = bigger_one.size + diff_size

    sum = 0
    bigger_one.each_pair do |k, v|
      (sum = sum + 1) if v == smaller_one[k]
    end
    r1 = sum.fdiv(bigger_one.size)

    sum2 = 0
    smaller_one.each_pair do |k, v|
      (sum2= sum2 + 1) if v == bigger_one[k]
    end
    r2 = (sum2).fdiv(ratio)
    (r1 + r2).fdiv(2)
  end
end 
