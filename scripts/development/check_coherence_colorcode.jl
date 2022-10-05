#= CheckList to pass
1. Verify to which displacement and which color corrresponds θ = 0,π/2,π,-π/2 on a Square Lattice.
2. Check that the colors of the visual aspect of a +/- defect rotates the good way.
3. Check that the defects are correctly localized
4. Check that the arrows of quiver! indicate the correct direction.
4bis. Check that the holes are correctly localized.
=#

## Step 0 : Comprendre heatmap
test = reshape(1:16,4,4)
test'
heatmap(test)
heatmap(test')

## Step 1 OK
L = 10
    model = MovingXY(params) # T,A,symmetry,propulsion,t,rho,algo,width_proposal
    lattice = SquareLattice(L)
i,j = 6,5 ; theta = pi
    thetas = NaN*zeros(L,L)
    thetas[i,j] = theta
    display(plot_thetas(thetas,model,lattice))
    NN = angle2neighbour(thetas[i,j],i,j,model,lattice)
    thetas[i,j] = NaN
    thetas[NN...] = theta
    display(plot_thetas(thetas,model,lattice))
#= Results for SquareLattice
θ = 0 is going up
θ = pi/2 is going left
θ = pi is going down
θ = -pi/2 is going right

Results for TriangularLattice
θ = 0 is going up
θ = pi/2 is going left
θ = pi is going down
θ = -pi/2 is going right (as for Square)
but now, for 'directions obliques', it depends on the parity of "i"

=#

## Step 2 OK
include(srcdir("../parameters.jl"));
    params["init"] = "single"
    params["q"] = 1/2
    params["type1defect"] = "sink"
    model = XY(params)
    lattice = SquareLattice(L,periodic=true,single=true)
    thetas = init_thetas(lattice,params=params)
    display(plot_thetas(thetas,model,lattice,defects=true))


## Step 3 OK
include(srcdir("../parameters.jl"));
    params["init"] = "single"
    params["q"] = q = 1/2
    params["symmetry"] = "nematic"
    model = XY(params)
    lattice = TriangularLattice(L,periodic=true,single=true)
x0,y0 = round(Int,L/2),round(Int,L/2)
    thetas = Float32.(create_single_defect(L,x0,y0,q=q,type=type1defect)) # in case of something more exotic, recall that the use is : create_single_defect(q,type,L,y0,x0) (x and y swapped)
    display(plot_thetas(thetas,model,lattice,defects=true))
x0,y0 = round(Int,L/2),round(Int,L/4)
    thetas = Float32.(create_single_defect(L,x0,y0,q=q,type=type1defect)) # in case of something more exotic, recall that the use is : create_single_defect(q,type,L,y0,x0) (x and y swapped)
    display(plot_thetas(thetas,model,lattice,defects=true))
x0,y0 = round(Int,L/4),round(Int,L/2)
    thetas = Float32.(create_single_defect(L,x0,y0,q=q,type=type1defect)) # in case of something more exotic, recall that the use is : create_single_defect(q,type,L,y0,x0) (x and y swapped)
    display(plot_thetas(thetas,model,lattice,defects=true))
x0,y0 = round(Int,L/4),round(Int,L/4)
    thetas = Float32.(create_single_defect(L,x0,y0,q=q,type=type1defect)) # in case of something more exotic, recall that the use is : create_single_defect(q,type,L,y0,x0) (x and y swapped)
    display(plot_thetas(thetas,model,lattice,defects=true))

## Step 4 and 4bis OK alhamdoullah
include(srcdir("../parameters.jl"));
    params["init"] = "single"
    params["q"] = 1/2
    params["rho"] = 1
    params["type1defect"] = "counterclockwise"
    params["symmetry"] = "polar"
    model = XY(params)
    lattice = SquareLattice(L,periodic=true,single=true)
    thetas = init_thetas(lattice,params=params)
    p = plot_thetas(thetas,model,lattice,defects=true)
    window = 9
    display_quiver!(p,thetas,window)