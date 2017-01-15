#!/bin/bash

run=11

echo ------------------------------ Vanilla YCSB HyperDex Load E -------------------------------
export LD_LIBRARY_PATH=/usr/local/lib
nohup echo alohomora | sudo -S iotop -btoqa | grep --line-buffered '/mnt/raid0/flsm/hyperdex_data_vanilla_ycsb11_e' > ycsb"$run"_hyperdex/iotop_vanilla_loade_50M$run.log &
date
./bin/ycsb load hyperdex -P workloads/workloade -p recordcount=50000000 -p operationcount=50000000 -p hyperclient.scannable=true -p hyperdex.scannable=true > ycsb"$run"_hyperdex/vanilla_loade_50M$run.log
date
echo alohomora | sudo -S kill `pgrep iotop`
echo -------------------------------------------------------------------------------------------

echo Sleeping for 10 seconds . . . 
sleep 10

mkdir -p /mnt/raid0/flsm/hyperdex_data_vanilla_ycsb11_e_loade
mkdir -p /mnt/raid0/flsm/hyperdex_coordinator_vanilla_ycsb11_e_loade
cp -r /mnt/raid0/flsm/hyperdex_data_vanilla_ycsb11_e/* /mnt/raid0/flsm/hyperdex_data_vanilla_ycsb11_e_loade/
cp -r /mnt/raid0/flsm/hyperdex_coordinator_vanilla_ycsb11_e/* /mnt/raid0/flsm/hyperdex_coordinator_vanilla_ycsb11_e_loade/

echo ------------------------------ Vanilla YCSB HyperDex Run E -------------------------------
export LD_LIBRARY_PATH=/usr/local/lib
nohup echo alohomora | sudo -S iotop -btoqa | grep --line-buffered '/mnt/raid0/flsm/hyperdex_data_vanilla_ycsb11_e' > ycsb"$run"_hyperdex/iotop_vanilla_rune_10M$run.log &
date
./bin/ycsb run hyperdex -P workloads/workloade -p recordcount=50000000 -p operationcount=10000000 -p hyperclient.scannable=true -p hyperdex.scannable=true > ycsb"$run"_hyperdex/vanilla_rune_10M$run.log
date
echo alohomora | sudo -S kill `pgrep iotop`
echo -------------------------------------------------------------------------------------------

