# [[file:notes.org::Kernel Top][Kernel Top]]
using Random, Distributions
using StatsPlots,KernelDensity
sizes=[20,60,100];
parr = fill(plot(),3,4);
# Kernel Top ends here

# [[file:notes.org::Kernel Normal][Kernel Normal]]
name = "Normal";
d = Normal(0,1);
for (i,size) in enumerate(sizes)
    for (j,m) in enumerate([0.5,1.0,2.0])
        sample = rand(d,size);
        U = kde(sample);
        x = range(-4,4,101);
        parr[i,j] = plot(x,y -> pdf(U,y), title="\$h = $m\\cdot h_n\$",label="kde");
        plot!(parr[i,j],x,pdf.(d,x),label="pdf",ylimits=(0,1));
    end
    parr[i,end] = plot(parr[i,1:3]...,layout=(1,3),plot_title="n=$size",size=(1500,500))
end
dplot = plot(parr[:,end]...,layout=(3,1),dpi=300);
savefig(dplot,"figs/kde$name");
# Kernel Normal ends here

# [[file:notes.org::Kernel Cauchy][Kernel Cauchy]]
name = "Cauchy";
d = Cauchy(0,1);
for (i,size) in enumerate(sizes)
    for (j,m) in enumerate([0.5,1.0,2.0])
        sample = rand(d,size);
        U = kde(sample);
        x = range(-4,4,101);
        parr[i,j] = plot(x,y -> pdf(U,y), title="\$h = $m\\cdot h_n\$",label="kde");
        plot!(parr[i,j],x,pdf.(d,x),label="pdf",ylimits=(0,1));
    end
    parr[i,end] = plot(parr[i,1:3]...,layout=(1,3),plot_title="n=$size",size=(1500,500))
end
dplot = plot(parr[:,end]...,layout=(3,1),dpi=300);
savefig(dplot,"figs/kde$name");
# Kernel Cauchy ends here

# [[file:notes.org::Kernel Laplace][Kernel Laplace]]
name = "Laplace";
d = Laplace(0,1/sqrt(2));
for (i,size) in enumerate(sizes)
    for (j,m) in enumerate([0.5,1.0,2.0])
        sample = rand(d,size);
        U = kde(sample);
        x = range(-4,4,101);
        parr[i,j] = plot(x,y -> pdf(U,y), title="\$h = $m\\cdot h_n\$",label="kde");
        plot!(parr[i,j],x,pdf.(d,x),label="pdf",ylimits=(0,1));
    end
    parr[i,end] = plot(parr[i,1:3]...,layout=(1,3),plot_title="n=$size",size=(1500,500))
end
dplot = plot(parr[:,end]...,layout=(3,1),dpi=300);
savefig(dplot,"figs/kde$name");
# Kernel Laplace ends here

# [[file:notes.org::Kernel Uniform][Kernel Uniform]]
name = "Uniform";
d = Uniform(-sqrt(3),sqrt(3));
for (i,size) in enumerate(sizes)
    for (j,m) in enumerate([0.5,1.0,2.0])
        sample = rand(d,size);
        U = kde(sample);
        x = range(-4,4,101);
        parr[i,j] = plot(x,y -> pdf(U,y), title="\$h = $m\\cdot h_n\$",label="kde");
        plot!(parr[i,j],x,pdf.(d,x),label="pdf",ylimits=(0,1));
    end
    parr[i,end] = plot(parr[i,1:3]...,layout=(1,3),plot_title="n=$size",size=(1500,500))
end
dplot = plot(parr[:,end]...,layout=(3,1),dpi=300);
savefig(dplot,"figs/kde$name");
# Kernel Uniform ends here

# [[file:notes.org::Kernel Poisson][Kernel Poisson]]
name = "Poisson";
d = Poisson(10);
for (i,size) in enumerate(sizes)
    for (j,m) in enumerate([0.5,1.0,2.0])
        sample = rand(d,size);
        U = kde(sample);
        x = range(6,14,101);
        parr[i,j] = plot(x,y -> pdf(U,y), title="\$h = $m\\cdot h_n\$",label="kde");
        plot!(parr[i,j],range(6,14,9),x -> pdf(d,x),label="pdf");
    end
    parr[i,end] = plot(parr[i,1:3]...,layout=(1,3),plot_title="n=$size",size=(1500,500))
end
dplot = plot(parr[:,end]...,layout=(3,1),dpi=300);
savefig(dplot,"figs/kde$name");
# Kernel Poisson ends here
