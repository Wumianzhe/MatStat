using Distributions,Statistics,Printf,DelimitedFiles,StatsPlots
using Optim

d = Normal();
x = -1.8:0.2:2;
y = 2 .+ 2*x + rand(d,size(x)[1])

struct Linreg
    β0::Float64
    β1::Float64
end

Linreg(b::Vector) = Linreg(b[1],b[2]);

function LSM(x,y)
    _x = mean(x);
    _y = mean(y);
    _xsq = mean(x.^2);
    _xy = mean(x.*y);
    β1 = (_xy - _x * _y)/(_xsq - _x^2)
    Linreg(_y - _x*β1,β1)
end

function LAD(x,y)
    abs_err(b) = sum(abs.(y - linpred(Linreg(b),x)))
    Linreg(optimize(abs_err,[0.0,1.0]).minimizer)
end

function linpred(linreg::Linreg,x::AbstractVector)
    linreg.β0 .+ linreg.β1 * x
end

function dist(linreg::Linreg,x::AbstractVector,y::AbstractVector)
    sum((y - linpred(linreg,x)).^2)
end

model = Linreg(2,2);

function res(x,y,name)
    lsreg = LSM(x, y)
    ladreg = LAD(x, y)
    scatter(x, y, label="data", dpi=300)
    plot!(x, linpred(model, x), label="Модель")
    plot!(x, linpred(lsreg, x), label="МНК")
    plot!(x, linpred(ladreg, x), label="МНМ")
    savefig("figs/$name.png")
    println("$name model: ",model, " ", dist(model, x, y))
    println("$name МНК: ",lsreg, " ", dist(lsreg, x, y))
    println("$name МНМ: ",ladreg, " ", dist(ladreg, x, y))
end

res(x,y,"linBase")
y[1] += 10;
y[20] -= 10;
res(x,y,"linMangled")
