# [[file:notes.org::Empyrical Top][Empyrical Top]]
using Random, Distributions
using StatsPlots
sizes=[20,60,100];
parr = fill(plot(),3,1);
# Empyrical Top ends here

# [[file:notes.org::Empyrical Normal][Empyrical Normal]]
name = "Normal";
d = Normal(0,1);
for (i,size) in enumerate(sizes)
    sample = sort(rand(d,size));
    ind = unique(i -> sample[i], eachindex(sample));
    x = range(-4,4,151);
    parr[i] = plot(sample[ind], ind/size,xlimits=(-4,4),title="n=$size",label="approx");
    plot!(parr[i],x,cdf.(d,x),label="cdf");
end
dplot = plot(parr...,layout=(1,3),dpi=300,size=(1500,350));
savefig(dplot,"figs/emp$name")
# Empyrical Normal ends here

# [[file:notes.org::Empyrical Cauchy][Empyrical Cauchy]]
name = "Cauchy";
d = Cauchy(0,1);
for (i,size) in enumerate(sizes)
    sample = sort(rand(d,size));
    ind = unique(i -> sample[i], eachindex(sample));
    x = range(-4,4,151);
    parr[i] = plot(sample[ind], ind/size,xlimits=(-4,4),title="n=$size",label="approx");
    plot!(parr[i],x,cdf.(d,x),label="cdf");
end
dplot = plot(parr...,layout=(1,3),dpi=300,size=(1500,350));
savefig(dplot,"figs/emp$name")
# Empyrical Cauchy ends here

# [[file:notes.org::Empyrical Laplace][Empyrical Laplace]]
name = "Laplace";
d = Laplace(0,1/sqrt(2));
for (i,size) in enumerate(sizes)
    sample = sort(rand(d,size));
    ind = unique(i -> sample[i], eachindex(sample));
    x = range(-4,4,151);
    parr[i] = plot(sample[ind], ind/size,xlimits=(-4,4),title="n=$size",label="approx");
    plot!(parr[i],x,cdf.(d,x),label="cdf");
end
dplot = plot(parr...,layout=(1,3),dpi=300,size=(1500,350));
savefig(dplot,"figs/emp$name")
# Empyrical Laplace ends here

# [[file:notes.org::Empyrical Uniform][Empyrical Uniform]]
name = "Uniform";
d = Uniform(-sqrt(3),sqrt(3));
for (i,size) in enumerate(sizes)
    sample = sort(rand(d,size));
    ind = unique(i -> sample[i], eachindex(sample));
    x = range(-4,4,151);
    parr[i] = plot(sample[ind], ind/size,xlimits=(-4,4),title="n=$size",label="approx");
    plot!(parr[i],x,cdf.(d,x),label="cdf");
end
dplot = plot(parr...,layout=(1,3),dpi=300,size=(1500,350));
savefig(dplot,"figs/emp$name")
# Empyrical Uniform ends here

# [[file:notes.org::Empyrical Poisson][Empyrical Poisson]]
name = "Poisson";
d = Poisson(10);
for (i,size) in enumerate(sizes)
    sample = sort(rand(d,size));
    ind = unique(i -> sample[i], eachindex(sample));
    x = range(6,14,151);
    parr[i] = plot(sample[ind], ind/size,xlimits=(6,14),title="n=$size",label="approx");
    plot!(parr[i],x,cdf.(d,x),label="cdf");
end
dplot = plot(parr...,layout=(1,3),dpi=300,size=(1500,350));
savefig(dplot,"figs/emp$name")
# Empyrical Poisson ends here
