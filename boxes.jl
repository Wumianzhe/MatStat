# [[file:notes.org::Boxplot Top][Boxplot Top]]
using Random, Distributions
using PlotlyJS
sizes = [20,100];
# Boxplot Top ends here

# [[file:notes.org::Boxplot Normal][Boxplot Normal]]
name = "Normal";
d = Normal(0,1);
p = plot([box(x=rand(d,size),name="n=$size") for size in sizes], Layout(title=name));
savefig(p,"figs/box$name.png");
# Boxplot Normal ends here

# [[file:notes.org::Boxplot Cauchy][Boxplot Cauchy]]
name = "Cauchy";
d = Cauchy(0,1);
p = plot([box(x=rand(d,size),name="n=$size") for size in sizes], Layout(title=name));
savefig(p,"figs/box$name.png");
# Boxplot Cauchy ends here

# [[file:notes.org::Boxplot Laplace][Boxplot Laplace]]
name = "Laplace";
d = Laplace(0,1/sqrt(2));
p = plot([box(x=rand(d,size),name="n=$size") for size in sizes], Layout(title=name));
savefig(p,"figs/box$name.png");
# Boxplot Laplace ends here

# [[file:notes.org::Boxplot Uniform][Boxplot Uniform]]
name = "Uniform";
d = Uniform(-sqrt(3),sqrt(3));
p = plot([box(x=rand(d,size),name="n=$size") for size in sizes], Layout(title=name));
savefig(p,"figs/box$name.png");
# Boxplot Uniform ends here

# [[file:notes.org::Boxplot Poisson][Boxplot Poisson]]
name = "Poisson";
d = Poisson(10);
p = plot([box(x=rand(d,size),name="n=$size") for size in sizes], Layout(title=name));
savefig(p,"figs/box$name.png");
# Boxplot Poisson ends here
