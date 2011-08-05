#!/bin/sh

##
## General settings
##

# suffix for output files
if [[ "$PBS_JOBNAME" != "" ]]
then
    : ${SUFFIX=_$PBS_JOBNAME}
else
    : ${SUFFIX=}
fi

: ${OUTPUT=1}  # produce output?
: ${TIME=1}    # produce timings?

##
## Data settings
##

: ${DATA_DIR=data}        # directory containing data files
: ${RESULTS_DIR=results}  # directory to contain result files

: ${INIT_FILENAME=init.nc}   # init file
: ${FORCE_FILENAME=}  # forcings file
: ${OBS_FILENAME=obs.nc}    # observations file

: ${INIT_NS=0}   # record along ns dimension to use for init file
: ${FORCE_NS=0}  # record along ns dimension to use for forcings file
: ${OBS_NS=1}    # record along ns dimension to use for observations file

##
## Simulation settings
##

: ${T=100}               # time to simulate
: ${K=101}                 # number of output points

if [[ `expr match "$PBS_JOBNAME" "^pf-pmatch"` > 0 ]]
then
: ${P=384}
elif [[ `expr match "$PBS_JOBNAME" "^mupf-pmatch"` > 0 ]]
then
: ${P=376}
elif [[ `expr match "$PBS_JOBNAME" "^apf-pmatch"` > 0 ]]
then
: ${P=192}
elif [[ `expr match "$PBS_JOBNAME" "^amupf-pmatch"` > 0 ]]
then
: ${P=184}
else
: ${P=64}
fi

: ${DELTA=1.0}             # step size for random and discrete-time variables
: ${H=1.0}                 # step size for ODE integrator
: ${ATOLER=1.0e-3}         # absolute error tolerance for ODE integrator
: ${RTOLER=1.0e-3}         # relative error tolerance for ODE integrator
: ${INCLUDE_PARAMETERS=1}  # include  parameters as well as state?

##
## Prediction settings
##

: ${U=730.0}  # time to which to predict

##
## Particle filter settings
##

# filter method
if [[ "$PBS_JOBNAME" != "" ]]
then
    : ${FILTER=$PBS_JOBNAME}
else
    : ${FILTER=cupf}      
fi

: ${RESAMPLER=stratified}  # resampling method
: ${ESS_REL=0.5}           # minimum relative ESS to trigger resampling
: ${SORT=1}                # sort weights before resampling
: ${B_ABS=0.0}             # absolute kernel bandwidth (0 to use B_REL instead)
: ${B_REL=1.0}             # relative kernel bandwidth
: ${SHRINK=1}              # apply shrinkage to kernel densities?

##
## Unscented Kalman filter settings
##

: ${UT_ALPHA=1.0e-3}  # alpha param for scaled unscented transformation
: ${UT_BETA=2.0}      # beta param for scaled unscented transformation
: ${UT_KAPPA=0.0}     # kappa param for scaled unscented transformation

##
## PMCMC settings
##

: ${C=204800}             # number of samples to draw
: ${A=10000000}               # centre of sigmoid for proposal adaptation
: ${BETA=1.0e-3}          # decay of sigmoid for proposal adaptation
: ${LAMBDA0=0}            # starting temperature for annealing
: ${GAMMA=1.0e-2}         # exponential decay of temperature for annealing
: ${S1=0.0}               # proposal covariance scaling (0 for default)
: ${S2=0.18}               # starting covariance scaling
: ${PROPOSAL_TYPE=file}  # proposal distribution type: file, prior, ukf, urts, pf, pfs or kfb
: ${STARTING_TYPE=file}  # starting distribution type: file, prior, ukf, urts, pf, pfs or kfb
: ${ADAPT=0}              # adapt proposal distribution?
: ${INCLUDE_INITIAL=0}    # include initial conditions in MCMC rather than filter?

##
## Likelihood settings
##

: ${M=200}  # frequency with which to change samples

##
## Random number settings
##

: ${SEED=34598}  # pseudorandom number seed

##
## System settings
## 

: ${OMP_NUM_THREADS=4}  # number of threads
