#!/bin/sh

# set up init file
octave -q --path oct --eval "prepare_init();"

# simulate a dense data set
libbi sample @config.conf --target joint --model-file PZ.bi --end-time 100 --noutputs 100 --init-file data/init.nc --output-file results/joint.nc --seed -1

# extract a sparse data set using OctBi
rm -f data/obs.nc
octave -q --eval "bi_sparsify_var('results/joint.nc', 'data/obs.nc', 'P_obs');"
