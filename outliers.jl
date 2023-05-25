# [[file:notes.org::Outliers Top][Outliers Top]]
using Random, Distributions
using Statistics
sizes=[20,100]
# Outliers Top ends here

# [[file:notes.org::Outliers Normal][Outliers Normal]]
name = "Normal";
d = Normal(0,1);
q = quantile(d,[0.25,0.75])
x1 = q[1] - 3/2*(q[2]-q[1])
x2 = q[2] + 3/2*(q[2]-q[1])
@info "$name bounds: $x1, $x2"
p = fill(0.0,2)
for (i,size) in enumerate(sizes)
    o = [count(x -> (x < x1) || (x > x2),rand(d,size)) for i in 0:1000]
    p[i] = mean(o)/size
end
println(p)
# Outliers Normal ends here

# [[file:notes.org::Outliers Cauchy][Outliers Cauchy]]
name = "Cauchy";
d = Cauchy(0,1);
q = quantile(d,[0.25,0.75])
x1 = q[1] - 3/2*(q[2]-q[1])
x2 = q[2] + 3/2*(q[2]-q[1])
@info "$name bounds: $x1, $x2"
p = fill(0.0,2)
for (i,size) in enumerate(sizes)
    o = [count(x -> (x < x1) || (x > x2),rand(d,size)) for i in 0:1000]
    p[i] = mean(o)/size
end
println(p)
# Outliers Cauchy ends here

# [[file:notes.org::Outliers Laplace][Outliers Laplace]]
name = "Laplace";
d = Laplace(0,1/sqrt(2));
q = quantile(d,[0.25,0.75])
x1 = q[1] - 3/2*(q[2]-q[1])
x2 = q[2] + 3/2*(q[2]-q[1])
@info "$name bounds: $x1, $x2"
p = fill(0.0,2)
for (i,size) in enumerate(sizes)
    o = [count(x -> (x < x1) || (x > x2),rand(d,size)) for i in 0:1000]
    p[i] = mean(o)/size
end
println(p)
# Outliers Laplace ends here

# [[file:notes.org::Outliers Uniform][Outliers Uniform]]
name = "Uniform";
d = Uniform(-sqrt(3),sqrt(3));
q = quantile(d,[0.25,0.75])
x1 = q[1] - 3/2*(q[2]-q[1])
x2 = q[2] + 3/2*(q[2]-q[1])
@info "$name bounds: $x1, $x2"
p = fill(0.0,2)
for (i,size) in enumerate(sizes)
    o = [count(x -> (x < x1) || (x > x2),rand(d,size)) for i in 0:1000]
    p[i] = mean(o)/size
end
println(p)
# Outliers Uniform ends here

# [[file:notes.org::Outliers Poisson][Outliers Poisson]]
name = "Poisson";
d = Poisson(10);
q = quantile(d,[0.25,0.75])
x1 = q[1] - 3/2*(q[2]-q[1])
x2 = q[2] + 3/2*(q[2]-q[1])
@info "$name bounds: $x1, $x2"
p = fill(0.0,2)
for (i,size) in enumerate(sizes)
    o = [count(x -> (x < x1) || (x > x2),rand(d,size)) for i in 0:1000]
    p[i] = mean(o)/size
end
println(p)
# Outliers Poisson ends here
