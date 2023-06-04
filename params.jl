using Distributions,Statistics,Printf,DelimitedFiles,StatsPlots

function norm_mean(data, α)
    n = size(data)[1]
    m = mean(data)
    s = stdm(data, m)
    t = quantile(TDist(n - 1), 1 - α / 2)
    d = s * t / sqrt(n - 1)
    m - d, m + d
end

function norm_std(data, α)
    n = size(data)[1]
    m = mean(data)
    s = stdm(data, m)
    q = quantile.(Chisq(n - 1), [1 - α / 2,α / 2])
    s*sqrt(n)/sqrt(q[1]), s*sqrt(n)/sqrt(q[2])
end

function asymp_mean(data,α)
    n = size(data)[1]
    m = mean(data)
    s = stdm(data, m)
    u = quantile(Normal(), 1 - α / 2)
    d = s * u / sqrt(n)
    m - d, m + d
end

function asymp_std(data,α)
    n = size(data)[1]
    s = std(data)
    m4 = moment(data,4)
    u = quantile(Normal(), 1 - α / 2)
    e = m4 / s^4 - 3
    U = u * sqrt((e + 2)/n)
    s / sqrt(1 + U), s / sqrt(1 - U)
end

sizes = [20,100]
α = 0.05;
nouts = Vector{Any}(undef,size(sizes)[1]);
aouts = Vector{Any}(undef,size(sizes)[1]);
for (i,s) in enumerate(sizes)
    data = rand(Normal(),s)
    n_mean_int = norm_mean(data,α)
    n_std_int = norm_std(data,α)
    n_mean_ext = (n_mean_int[1] - n_std_int[2],n_mean_int[2] + n_std_int[2])
    a_mean_int = asymp_mean(data,α)
    a_std_int = asymp_std(data,α)
    a_mean_ext = (a_mean_int[1] - a_std_int[2],a_mean_int[2] + a_std_int[2])

    n_mint_l,n_mint_r = round.(n_mean_int,digits=3)
    n_sint_l,n_sint_r = round.(n_std_int,digits=3)
    n_mext_l,n_mext_r = round.(n_mean_ext,digits=3)
    a_mint_l,a_mint_r = round.(a_mean_int,digits=3)
    a_sint_l,a_sint_r = round.(a_std_int,digits=3)
    a_mext_l,a_mext_r = round.(a_mean_ext,digits=3)

    nouts[i] = ["size=$s" "\$\\mu\$" "\$\\sigma\$" "\$\\mu = [internal \\subseteq external]\$"
               "" "$n_mint_l < \$\\mu\$ < $n_mint_r" "$n_sint_l < \$\\sigma\$ < $n_sint_r" "[$n_mint_l,$n_mint_r] \$\\subseteq\$ [$n_mext_l,$n_mext_r]"]
    aouts[i] = ["size=$s" "\$\\mu\$" "\$\\sigma\$" "\$\\mu = [internal \\subseteq external]\$"
               "" "$a_mint_l < \$\\mu\$ < $a_mint_r" "$a_sint_l < \$\\sigma\$ < $a_sint_r" "[$a_mint_l,$a_mint_r] \$\\subseteq\$ [$a_mext_l,$a_mext_r]"]
end
open("figs/interNorm.csv", "w") do io
    writedlm(IOContext(io, :compact => true), reduce(vcat, nouts), ',')
end
open("figs/interAsimp.csv", "w") do io
    writedlm(IOContext(io, :compact => true), reduce(vcat, aouts), ',')
end
