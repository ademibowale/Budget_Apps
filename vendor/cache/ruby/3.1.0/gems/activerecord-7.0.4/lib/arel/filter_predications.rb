module Arel
  module FilterPredications
    def filter(expr)
      Nodes::Filter.new(self, expr)
    end
  end
end
