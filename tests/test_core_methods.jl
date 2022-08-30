include("../src/core_methods.jl");
include("../src/init_visu.jl");

using BenchmarkTools
## Tests get neighbours
# Physical Parameters
L = 200
    T = 0.1
    symmetry = "polar"
    Var = 0.1
    vision = π
    params_phys = Dict("L"=>L,"T"=>T,"Var"=>Var,"vision"=>vision,"symmetry"=>symmetry)

# Numerical Parameters
dt = 1E-2
    float_type = Float32
    params_num  = Dict("dt"=>dt,"float_type"=>float_type)

lattice = TriangularLattice(L,periodic=true,single=true)
thetas = init_thetas(lattice,init="2pair",q=1,r0=60,type=["source","divergent"])

## Checks whether the number of NN is plausible
i = 10; j=10
model = XY(params_phys,params_num)
    @btime get_neighbours(thetas,model,lattice,i,j)
model = AXY(params_phys,params_num)
    @btime get_neighbours(thetas,model,lattice,i,j)
model = VisionXY(params_phys,params_num)
angle_neighbours = get_neighbours(thetas,model,lattice,i,j,true)
sum_influence_neighbours(thetas[i,j],angle_neighbours,model,lattice)
@btime get_neighbours(thetas,model,lattice,i,j,true)
@btime sum_influence_neighbours(thetas[i,j],angle_neighbours,model,lattice)


## Tests update!()
model = XY(params_phys,params_num)
    @btime update!(thetas,model,lattice)
model = AXY(params_phys,params_num)
    @btime update!(thetas,model,lattice)
model = VisionXY(params_phys,params_num)
    @btime update!(thetas,model,lattice)

# Tests update!(....,tmax)
tmax = 1
model = XY(params_phys,params_num)
model.t
update!(thetas,model,lattice)
model.t
update!(thetas,model,lattice,tmax)
model.t

## Complexity of update!()
L = 100 ; params_phys = Dict("L"=>L,"T"=>T,"Var"=>Var,"vision"=>vision,"symmetry"=>symmetry)
model = XY(params_phys,params_num)
    @btime get_neighbours(model,lattice,i,j)
