# This class defaults to minimum heap.
# For max heap ----> BinaryHeap.new { |a, b| b <=> a }

class BinaryHeap
  attr_reader :store, :prc

  def initialize(&prc)
    @store = []
    @prc = prc || Proc.new { |a, b| a <=> b }
  end

  def count
    @store.length
  end

  def extract
    @store[0], @store[-1], = @store[-1], @store[0]
    element = @store.pop
    BinaryHeap.heapify_down(@store, 0, count, &@prc)
    element
  end

  def peek
    @store[0]
  end

  def push(val)
    @store << val
    BinaryHeap.heapify_up(@store, count-1, count, &@prc)
  end

  public
  def self.child_indices(len, parent_index)
    first = 2 * parent_index + 1
    second = 2 * parent_index + 2
    first >= len ? [] : second >= len ? [first] : [first, second]
  end

  def self.parent_index(child_index)
    raise 'root has no parent' if child_index <= 0
    (child_index - 1) / 2
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    prc ||= Proc.new { |a, b| a <=> b }
    while parent_idx < len
      children = child_indices(len, parent_idx)
      break if children.empty?

      if children.length == 1
        child_idx = children[0]
      else
        a, b = children
        child_idx = (prc.call(array[a], array[b]) == 1) ? b : a
      end

      if prc.call(array[parent_idx], array[child_idx]) == 1
        array[parent_idx], array[child_idx] = array[child_idx], array[parent_idx]
        parent_idx = child_idx
      else
        break
      end
    end
    array
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    prc ||= Proc.new { |a, b| a <=> b }
    while child_idx > 0
      parent_idx = parent_index(child_idx)
      if prc.call(array[parent_idx], array[child_idx]) == 1
        array[parent_idx], array[child_idx] = array[child_idx], array[parent_idx]
        child_idx = parent_idx
      else
        break
      end
    end
    array
  end
end
