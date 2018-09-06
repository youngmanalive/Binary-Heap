require_relative "heap"

class Array
  def heap_sort!
    prc = Proc.new { |a, b| b <=> a }

    0.upto(self.length-1) do |i|
      BinaryMinHeap.heapify_up(self, i, &prc)
    end

    (self.length-1).downto(0) do |i|
      self[0], self[i] = self[i], self[0]
      BinaryMinHeap.heapify_down(self, 0, i, &prc)
    end

    self
  end
end
