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


def print_matrix(lines,columns,precision,array)
  matrix = ''
  lines.times do |i|
    columns.times do |j|
      element = (array[j][i].round(precision)).to_s
      element = "%.#{precision}f"%element
      space = precision + 5 - element.size
      if precision == 0 then space = 2 end
      matrix += " "*space+element
    end
    matrix += "\n"
  end
  puts matrix+"\n"
end

