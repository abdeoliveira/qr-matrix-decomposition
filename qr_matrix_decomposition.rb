#####INPUT 'A' MATRIX###

a = [[1,1,0],[1,0,1],[0,1,1]]

#=======================


load 'functions.rb'


u = []
e = []
r = []

ncol = a.length
nlin = a[0].length


j = 0
u[j] = a[j]
e[j] = director(u[j])



(1..ncol-1).each do |j|
  cv = cumulative_vector(a,e,j,nlin)
  u[j] = sumsub(a[j],cv,-1)
  e[j] = director(u[j])
end



ncol.times do |i|
  tmp = []
  ncol.times do |j|
    tmp[j] = inner(a[i],e[j])
  end
  r[i] = tmp
end


puts "A:"
print_matrix(nlin,ncol,0,a)
  
puts "Q:"
print_matrix(nlin,ncol,4,e)

puts "R:"
print_matrix(ncol,ncol,4,r)
