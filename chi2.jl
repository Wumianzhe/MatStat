using Distributions,Statistics,Printf,DelimitedFiles,StatsPlots
using Optim

function chi(name, data)
    function L(par)
        d = Normal(par[1],par[2])
        -sum(logpdf.(d,data))
    end
    μ,σ = optimize(L,[1.0,1.0]).minimizer
    println("$name: μ: $μ, σ: $σ")

    d = Normal(μ,σ);
    k = Integer(floor(1.72 * size(data)[1]^(1/3)));
    borders = collect(range(minimum(data),maximum(data),k-1));
    prepend!(borders,-Inf);
    append!(borders,Inf);
    table = [];
    append!(table,[["i" "\$\\Delta_i\$" "\$n_i\$" "\$p_i\$" "\$np_i\$" "\$n_i - np_i\$" "\$\\frac{(n_i - np_i)^2}{np_i}\$"]]);

    ns = [];
    ps = [];
    nps = [];
    difs = [];
    ress = [];
    for i in 1:size(borders)[1]-1
        left = borders[i]
        right = borders[i+1]
        curs = Vector{Any}(undef,5);

        curs[1] = ni = count(x -> left < x && x <= right,data)
        append!(ns,ni);
        curs[2] = pi = cdf(d,right) - cdf(d,left);
        append!(ps,pi);
        curs[3] = np = size(data)[1] * pi;
        append!(nps,np);
        curs[4] = dif = ni - np;
        append!(difs,dif);
        curs[5] = res = dif^2 / np;
        append!(ress,res);

        left = round(left,digits=2);
        right = round(right, digits=2);

        append!(table,[["$i" "($left,$right]" map(x -> @sprintf("%6.3f", x), permutedims(curs))]])
    end
    append!(table,[["\$\\sum\$" "-" map(x -> @sprintf("%6.3f", sum(x)), permutedims([ns,ps,nps,difs,ress]))]])
    open("figs/chi$name.csv", "w") do io
        writedlm(IOContext(io, :compact => true), reduce(vcat, table), ',')
    end
end

data = rand(Normal(),100)
chi("Normal",data)
data = rand(Laplace(0,1/sqrt(2)),20)
chi("Laplace",data)
data = rand(Uniform(-sqrt(3),sqrt(3)),20)
chi("Uniform",data)
