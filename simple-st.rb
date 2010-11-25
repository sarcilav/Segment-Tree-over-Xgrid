class SegmentTree
  attr_accessor :n, :tree
  def initialize(n = 100000)
    @n = n
    @tree = Array.new(n * 4,0)
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
    end
    @tree[node] += by
  end
  def output
    f = File.open "tree" , "w"
    f.puts @tree.inspect
    f.flush
    f.close
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
   
    a = Thread.new do
      if from <= mid #si necesitamos ir por la izquierda
        res += `xgrid -h mela.local -job run -in ./agent ./agent_st.rb "#{from}" "#{min(to, mid)}" "#{node * 2 + 1}" "#{left}" "#{mid}"`.to_i
      end      
    end
    b = Thread.new do
      if to > mid #si necesitamos ir por la derecha
        res += `xgrid -h mela.local -job run -in ./agent ./agent_st.rb "#{max(mid + 1, from)}" "#{to}" "#{node * 2 + 2}" "#{mid + 1}" "#{right}"`.to_i
      end
    end
    a.join
    b.join
    return res
  end
  
  #inicializa todo el arbol con cero
  def init
    for i in 0...@tree.size
      @tree[i] = 0
    end
  end
end
s = SegmentTree.new(100000)
for i in 0...100000
  s.update(i,i+1)
end
#s.output
puts "lets do some shit"
a = Thread.new { puts " sum(0,90) #{s.sum(0,90)}" }
b = Thread.new { puts " sum(0,1900) #{s.sum(0,1900)}" }
c = Thread.new { puts " sum(0,29000) #{s.sum(0,29000)}" }
d = Thread.new { puts " sum(0,59000) #{s.sum(0,59000)}" }
e = Thread.new { puts " sum(0,99000) #{s.sum(0,99000)}" }
f = Thread.new { puts " sum(19000,99000) #{s.sum(19000,99000)}" }
[a,b,c,d,e,f].each do |x|
  x.join
end
