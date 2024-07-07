def norm(vector)
  sumv = 0
  vector.each do |v|
    sumv += v**2
  end
  return Math.sqrt(sumv)
end



def director(vector)
  e = []
  vector.each do |v|
    e << v/norm(vector)
  end
  return e
end



def inner(vec1,vec2)
  sum = 0
  vec1.each.with_index do |v1,i|
    sum += v1*vec2[i]
  end
  return sum
end



def sumsub(vec2,vec1,signal)
  sub = []
  vec1.each.with_index do |v1,i|
    sub << vec2[i] + signal*v1
  end
  return sub
end



def scalar_multiply(scalar,vector)
  return vector.map { |v| v*scalar }
end



def cumulative_vector(a,e,j)
  sum = Array.new(@nlin, 0)
  tmp = []
  (0..j-1).each do |i|
    tmp = scalar_multiply( inner(a[j],e[i]) , e[i] )
    sum = sumsub(tmp,sum,1)
  end
  return sum
end

#================================

a = []
u = []
e = []
r = []

#a = [[12,6,-4],[-51,167,24],[4,-68,-41]]
a = [[1,1,0],[1,0,1],[0,1,1]]
#a = [[1,1,1],[1,2,3]]

  @ncol = a.length
  @nlin = a[0].length


  j = 0
  u[j] = a[j]
  e[j] = director(u[j])



  (1..@ncol-1).each do |j|
    cv = cumulative_vector(a,e,j)
    u[j] = sumsub(a[j],cv,-1)
    e[j] = director(u[j])
  end



  @ncol.times do |i|
    tmp = []
    @ncol.times do |j|
      tmp[j] = inner(a[i],e[j]).round(4)
    end
    r[i] = tmp
  end


  puts "A:"
  matrix = ''
  @nlin.times do |i|
    @ncol.times do |j|
      element = (a[j][i].round(4)).to_s
      space = 3-element.size
      matrix += " "*space+element
    end
    matrix += "\n"
  end
  puts matrix+"\n"

  
  puts "Q:"
  matrix = ''
  @nlin.times do |i|
    @ncol.times do |j|
      element = (e[j][i].round(4)).to_s
      space = 9-element.size
      matrix += " "*space+element
    end
    matrix += "\n"
  end
  puts matrix+"\n"



  puts "R:"
  matrix = ''
  @ncol.times do |i|
    @ncol.times do |j|
      element = (r[j][i].round(4)).to_s
      space = 8-element.size
      matrix += " "*space+element
    end
    matrix += "\n"
  end
  puts matrix



