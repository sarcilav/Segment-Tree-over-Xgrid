#!/usr/bin/ruby
class SegmentTree
  def self.max(a,b)
    a > b ? a : b
  end
  def self.min(a,b)
    a < b ? a : b
  end
  #determina la suma de los elementos del intervalo [from, to]
  #la funcion es tal que node representa el intervalo [left, right] 
  #y [from, to] siempre es subconjunto de [left, right]
  def self.sum(from, to, node , left, right)
    tree = eval File.open("/tmp/xgrid_tree").gets
    if from == left and to == right
      # si el segmento [left, right] es parte de lo que queremos sumar
      return tree[node]
    end
    mid = (left + right) / 2
    res = 0
    if from <= mid #si necesitamos ir por la izquierda
      res += sum(from, min(to, mid), node * 2 + 1, left, mid)
    end
    
    if to > mid #si necesitamos ir por la derecha
      res += sum(max(mid + 1, from) , to , node * 2 + 2 , mid + 1 , right)
    end
    return res
  end
end

puts SegmentTree.sum(ARGV[0].to_i , ARGV[1].to_i , ARGV[2].to_i , ARGV[3].to_i , ARGV[4].to_i)
