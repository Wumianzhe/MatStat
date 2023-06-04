using Distributions,Statistics,Printf,DelimitedFiles,StatsPlots

function r(sample)
    mcov = cov(sample,dims=2);
    mcov[1,2] / sqrt(mcov[1,1]*mcov[2,2])
end

function rq(sample)
    _x = mean(sample[1,:]);
    _y = mean(sample[2,:]);
    n1 = count(x -> x < _x,sample[1,:]);
    n2 = count(x -> x > _x,sample[1,:]);
    n3 = count(x -> x < _y,sample[2,:]);
    n4 = count(x -> x < _y,sample[2,:]);
    ((n1 + n3) - (n2 + n4))/size(sample)[2]
end

function rs(sample)
    local xs = sort(sample[1,:]);
    local ys = sort(sample[2,:]);
    ix = indexin(sample[1,:],xs);
    iy = indexin(sample[2,:],ys);
    r(vcat(ix',iy'))
end

sizes = [20,60,100];
funcs = [r,rq,rs];
E = fill(0.0,size(funcs)[1]);
Esq = fill(0.0,size(funcs)[1]);
D = fill(0.0,size(funcs)[1]);
outs = Vector{Any}(undef,size(sizes)[1]);
for s in sizes
    parr = fill(plot(),4);
    for (i,rh) in enumerate([0,0.5,0.9])
        local d = MvNormal([0,0],[1 rh;rh 1])
        samples = [rand(d, s) for k in 1:1000]
        for (j,f) in enumerate(funcs)
            vals = f.(samples);
            E[j] = mean(vals);
            Esq[j] = mean(vals.^2);
            D[j] = stdm(vals,E[j]);
        end
        outs[i] = ["\\rho=$rh" fill("", 1, size(funcs)[1])
                   "" "\$r\$" "\$r_S\$" "\$r_Q\$"
                   "E(z)" map(x -> @sprintf("%6.3f", x), permutedims(E))
                   "\$E(z^2)\$" map(x -> @sprintf("%6.3f", x), permutedims(Esq))
                   "D(z)" map(x -> @sprintf("%6.3f", x), permutedims(D))
                   fill("", 1, size(funcs)[1]+1)]
        parr[i] = scatter(samples[1][1,:],samples[1][2,:],xlimits=(-3,3),ylimits=(-3,3),title="\\rho=$rh",legend=false);
        covellipse!(parr[i],d.μ,d.Σ,n_std=2)
    end
    parr[end] = plot(parr[1:3]...,layout=(1,3),plot_title="n=$s",size=(1500,500));
    savefig(parr[end],"figs/ell$s")
    open("figs/char$s.csv", "w") do io
        writedlm(IOContext(io, :compact => true), reduce(vcat, outs), ',')
    end
end

parr = fill(plot(),4);
for (i,s) in enumerate(sizes)
    d1 = MvNormal([0,0],[1 0.9;0.9 1]);
    d2 = MvNormal([0,0],[10 -9;-9 10]);
    samples = [0.9*rand(d1, s)+0.1*rand(d2,s) for k in 1:1000]
    for (j,f) in enumerate(funcs)
        vals = f.(samples);
        E[j] = mean(vals);
        Esq[j] = mean(vals.^2);
        D[j] = stdm(vals,E[j]);
    end
    outs[i] = ["size=$s" fill("", 1, size(funcs)[1])
               "" "\$r\$" "\$r_S\$" "\$r_Q\$"
               "E(z)" map(x -> @sprintf("%6.3f", x), permutedims(E))
               "\$E(z^2)\$" map(x -> @sprintf("%6.3f", x), permutedims(Esq))
               "D(z)" map(x -> @sprintf("%6.3f", x), permutedims(D))
               fill("", 1, size(funcs)[1]+1)]
    parr[i] = scatter(samples[1][1,:],samples[1][2,:],xlimits=(-3,3),ylimits=(-3,3),title="size=$s",legend=false);
    covellipse!(parr[i],[mean(samples[1][k,:]) for k in 1:size(samples[1])[1]],cov(samples[1],dims=2),n_std=2)
end
parr[end] = plot(parr[1:3]...,layout=(1,3),plot_title="Смесь распределений",size=(1500,500));
savefig(parr[end],"figs/ellMix")
open("figs/charMix.csv", "w") do io
    writedlm(IOContext(io, :compact => true), reduce(vcat, outs), ',')
end
