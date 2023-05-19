# [[file:notes.org::Characteristics Top][Characteristics Top]]
using Random, Distributions
using Statistics,DelimitedFiles,Printf
sizes = [10,50,1000];
extr(itr) = (minimum(itr) + maximum(itr))/2; # extremes
quart(itr) = mean(quantile(itr,[0.25,0.75])); # quantile avg
function truncAvg(itr) # truncated average
    r:: Integer = round(length(itr) / 4);
    return mean(itr[r:length(itr) - r])
end
# Characteristics Top ends here

# [[file:notes.org::Characteristics Normal][Characteristics Normal]]
name = "Normal";
d = Normal(0,1);
outs = Vector{Any}(undef,3);
E = fill(0.0,5);
D = fill(0.0,5);
for (i,size) in enumerate(sizes)
    for (j,f) in enumerate([mean,median,extr,quart,truncAvg])
        vals = [f(rand(d,size)) for k in 0:1000];
        E[j] = mean(vals);
        D[j] = stdm(vals,E[j]);
    end
    outs[i] = ["$name n=$size" fill("",1,5); "" "\$\\overline{x}\$" "\$med x\$" "\$z_R\$" "\$z_Q\$" "\$z_{tr}\$"
       "E(z)" map(x->@sprintf("%6.3f",x),permutedims(E)); "D(z)" map(x->@sprintf("%6.3f",x),permutedims(D)); fill("",1,6)];
end
open("figs/char$name.csv","w") do io
    writedlm(IOContext(io,:compact => true),reduce(vcat,outs),',')
end
# Characteristics Normal ends here

# [[file:notes.org::Characteristics Cauchy][Characteristics Cauchy]]
name = "Cauchy";
d = Cauchy(0,1);
outs = Vector{Any}(undef,3);
E = fill(0.0,5);
D = fill(0.0,5);
for (i,size) in enumerate(sizes)
    for (j,f) in enumerate([mean,median,extr,quart,truncAvg])
        vals = [f(rand(d,size)) for k in 0:1000];
        E[j] = mean(vals);
        D[j] = stdm(vals,E[j]);
    end
    outs[i] = ["$name n=$size" fill("",1,5); "" "\$\\overline{x}\$" "\$med x\$" "\$z_R\$" "\$z_Q\$" "\$z_{tr}\$"
       "E(z)" map(x->@sprintf("%6.3f",x),permutedims(E)); "D(z)" map(x->@sprintf("%6.3f",x),permutedims(D)); fill("",1,6)];
end
open("figs/char$name.csv","w") do io
    writedlm(IOContext(io,:compact => true),reduce(vcat,outs),',')
end
# Characteristics Cauchy ends here

# [[file:notes.org::Characteristics Laplace][Characteristics Laplace]]
name = "Laplace";
d = Laplace(0,1/sqrt(2));
outs = Vector{Any}(undef,3);
E = fill(0.0,5);
D = fill(0.0,5);
for (i,size) in enumerate(sizes)
    for (j,f) in enumerate([mean,median,extr,quart,truncAvg])
        vals = [f(rand(d,size)) for k in 0:1000];
        E[j] = mean(vals);
        D[j] = stdm(vals,E[j]);
    end
    outs[i] = ["$name n=$size" fill("",1,5); "" "\$\\overline{x}\$" "\$med x\$" "\$z_R\$" "\$z_Q\$" "\$z_{tr}\$"
       "E(z)" map(x->@sprintf("%6.3f",x),permutedims(E)); "D(z)" map(x->@sprintf("%6.3f",x),permutedims(D)); fill("",1,6)];
end
open("figs/char$name.csv","w") do io
    writedlm(IOContext(io,:compact => true),reduce(vcat,outs),',')
end
# Characteristics Laplace ends here

# [[file:notes.org::Characteristics Poisson][Characteristics Poisson]]
name = "Poisson";
d = Poisson(10);
outs = Vector{Any}(undef,3);
E = fill(0.0,5);
D = fill(0.0,5);
for (i,size) in enumerate(sizes)
    for (j,f) in enumerate([mean,median,extr,quart,truncAvg])
        vals = [f(rand(d,size)) for k in 0:1000];
        E[j] = mean(vals);
        D[j] = stdm(vals,E[j]);
    end
    outs[i] = ["$name n=$size" fill("",1,5); "" "\$\\overline{x}\$" "\$med x\$" "\$z_R\$" "\$z_Q\$" "\$z_{tr}\$"
       "E(z)" map(x->@sprintf("%6.3f",x),permutedims(E)); "D(z)" map(x->@sprintf("%6.3f",x),permutedims(D)); fill("",1,6)];
end
open("figs/char$name.csv","w") do io
    writedlm(IOContext(io,:compact => true),reduce(vcat,outs),',')
end
# Characteristics Poisson ends here

# [[file:notes.org::Characteristics Uniform][Characteristics Uniform]]
name = "Uniform";
d = Uniform(-sqrt(3),sqrt(3));
outs = Vector{Any}(undef,3);
E = fill(0.0,5);
D = fill(0.0,5);
for (i,size) in enumerate(sizes)
    for (j,f) in enumerate([mean,median,extr,quart,truncAvg])
        vals = [f(rand(d,size)) for k in 0:1000];
        E[j] = mean(vals);
        D[j] = stdm(vals,E[j]);
    end
    outs[i] = ["$name n=$size" fill("",1,5); "" "\$\\overline{x}\$" "\$med x\$" "\$z_R\$" "\$z_Q\$" "\$z_{tr}\$"
       "E(z)" map(x->@sprintf("%6.3f",x),permutedims(E)); "D(z)" map(x->@sprintf("%6.3f",x),permutedims(D)); fill("",1,6)];
end
open("figs/char$name.csv","w") do io
    writedlm(IOContext(io,:compact => true),reduce(vcat,outs),',')
end
# Characteristics Uniform ends here
