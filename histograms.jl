# [[file:notes.org::imports][imports]]
using Random, Distributions, StatsPlots
# imports ends here

# [[file:notes.org::Histogram Normal][Histogram Normal]]
name = "Normal"
d = Normal(0,1)
parr = fill(plot(),3,1);
xmin = -5;
xmax = 5;
x = range(xmin,xmax,101);
sizes = [10,50,1000]
bins = [10,20,50]
for (i,size) in enumerate(sizes)
    sample = rand(d,size);
    parr[i] = histogram(sample, normalize = :pdf,bins=range(xmin,xmax,length=bins[i]+1), legend=false, title="$name distribution n=$size", xlimits=(xmin,xmax));
    plot!(parr[i],x, pdf.(d,x),linewidth=1.5);
end
dplot = plot(parr...,layout=(1,3),dpi=300,size=(1500,350));
savefig(dplot,"figs/hist" * name)
# Histogram Normal ends here

# [[file:notes.org::Histogram Cauchy][Histogram Cauchy]]
name = "Cauchy"
d = Cauchy(0,1)
parr = fill(plot(),3,1);
xmin = -5;
xmax = 5;
x = range(xmin,xmax,101);
sizes = [10,50,1000]
bins = [10,20,50]
for (i,size) in enumerate(sizes)
    sample = rand(d,size);
    parr[i] = histogram(sample, normalize = :pdf,bins=range(xmin,xmax,length=bins[i]+1), legend=false, title="$name distribution n=$size", xlimits=(xmin,xmax));
    plot!(parr[i],x, pdf.(d,x),linewidth=1.5);
end
dplot = plot(parr...,layout=(1,3),dpi=300,size=(1500,350));
savefig(dplot,"figs/hist" * name)
# Histogram Cauchy ends here

# [[file:notes.org::Histogram Laplace][Histogram Laplace]]
name = "Laplace"
d = Laplace(0,1/sqrt(2))
parr = fill(plot(),3,1);
xmin = -5;
xmax = 5;
x = range(xmin,xmax,101);
sizes = [10,50,1000]
bins = [10,20,50]
for (i,size) in enumerate(sizes)
    sample = rand(d,size);
    parr[i] = histogram(sample, normalize = :pdf,bins=range(xmin,xmax,length=bins[i]+1), legend=false, title="$name distribution n=$size", xlimits=(xmin,xmax));
    plot!(parr[i],x, pdf.(d,x),linewidth=1.5);
end
dplot = plot(parr...,layout=(1,3),dpi=300,size=(1500,350));
savefig(dplot,"figs/hist" * name)
# Histogram Laplace ends here

# [[file:notes.org::Histogram Uniform][Histogram Uniform]]
name = "Uniform"
d = Uniform(-sqrt(3),sqrt(3))
parr = fill(plot(),3,1);
xmin = -5;
xmax = 5;
x = range(xmin,xmax,101);
sizes = [10,50,1000]
bins = [10,20,50]
for (i,size) in enumerate(sizes)
    sample = rand(d,size);
    parr[i] = histogram(sample, normalize = :pdf,bins=range(xmin,xmax,length=bins[i]+1), legend=false, title="$name distribution n=$size", xlimits=(xmin,xmax));
    plot!(parr[i],x, pdf.(d,x),linewidth=1.5);
end
dplot = plot(parr...,layout=(1,3),dpi=300,size=(1500,350));
savefig(dplot,"figs/hist" * name)
# Histogram Uniform ends here

# [[file:notes.org::Histogram Poisson][Histogram Poisson]]
name = "Poisson"
d = Poisson(10)
parr = fill(plot(),3,1);
λ = params(d)[1];
sizes = [10,50,1000]
bins = [10,20,50]
poisPDF(x) = 1/sqrt(2pi * λ) * exp(-(x-λ)^2/(2λ)) # pdf(d,x) is only defined for natural x in Julia
for (i,size) in enumerate(sizes)
    sample = rand(d,size);
    xmin = minimum(sample);
    xmax = maximum(sample);
    x = range(xmin-3,xmax+3,151);
    # bins use Freedman-Diaconis rule
    parr[i] = histogram(sample, normalize= :pdf,  legend=false, title="Poisson distribution n=$size", xlimits=(xmin-3,xmax+3))
    plot!(parr[i],x, poisPDF.(x), linewidth=1.5);
end
dplot = plot(parr...,layout=(1,3),dpi=300,size=(1500,350));
savefig(dplot,"figs/hist" * name )
# Histogram Poisson ends here
