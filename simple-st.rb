class SegmentTree
  attr_accessor :n, :tree
  def initialize(n = 100000)
    @n = n
    @tree = Array.new(n * 4)
    init
  end
  def max(a,b)
    a > b ? a : b
  end
  def min(a,b)
    a < b ? a : b
  end
  #actualiza en el arbol un valor de la lista de numeros
  def update(pos, by)
    node = 0
    left = 0
    right = @n - 1 #intervalo inicial [0, n -1]
    while left != right
      #mientras tengamos que dividir el intervalo actual
      @tree[node] += by
      mid = (left + right) / 2
      if pos <= mid
        node = node * 2 + 1 #hijo de la izquierda [left, mid]
        right = mid
      else
        node = node * 2 + 2 #hijo de la derecha [mid + 1, right]
        left = mid + 1
      end
      @tree[node] += by
    end
  end
  
  
  #determina la suma de los elementos del intervalo [from, to]
  #la funcion es tal que node representa el intervalo [left, right] 
  #y [from, to] siempre es subconjunto de [left, right]
  def sum(from, to, node = 0, left = 0, right = n - 1)
    if from == left and to == right
      # si el segmento [left, right] es parte de lo que queremos sumar
      return @tree[node]
    end
    mid = (left + right) / 2
    res = 0
    if from <= mid #si necesitamos ir por la izquierda
      res += sum(from, min(to, mid), node * 2 + 1, left, mid)
    end
    if to > mid #si necesitamos ir por la derecha
      res += sum(max(mid + 1, from), to, node * 2 + 2, mid + 1, right)
    end
    return res
  end
  
  #inicializa todo el arbol con cero
  def init
    for i in 0...@tree.size
      @tree[i] = 0
    end
  end
end
s = SegmentTree.new(10)
for i in 0...10
  s.update(i,i+1)
end
puts s.sum(0,9)
