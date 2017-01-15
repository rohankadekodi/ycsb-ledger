#!/bin/bash

run=11

echo ------------------------------ FLSM YCSB HyperDex Load A -------------------------------
export LD_LIBRARY_PATH=/usr/local/lib
#nohup echo alohomora | sudo -S iotop -btoqa | grep --line-buffered '/mnt/raid0/flsm/hyperdex_data_flsm_ycsb11_a' > ycsb"$run"_hyperdex/iotop_flsm_loada_20M$run.log &
date
#./bin/ycsb load hyperdex -P workloads/workloada -p recordcount=20000000 -p operationcount=20000000 > ycsb"$run"_hyperdex/flsm_loada_20M$run.log
date
#echo alohomora | sudo -S kill `pgrep iotop`
echo -------------------------------------------------------------------------------------------

echo Sleeping for 10 seconds . . . 
sleep 10

#mkdir -p /mnt/raid0/flsm/hyperdex_data_flsm_ycsb11_a_loada
#mkdir -p /mnt/raid0/flsm/hyperdex_coordinator_flsm_ycsb11_a_loada
#cp -r /mnt/raid0/flsm/hyperdex_data_flsm_ycsb11_a/* /mnt/raid0/flsm/hyperdex_data_flsm_ycsb11_a_loada/
#cp -r /mnt/raid0/flsm/hyperdex_coordinator_flsm_ycsb11_a/* /mnt/raid0/flsm/hyperdex_coordinator_flsm_ycsb11_a_loada/

echo ------------------------------ FLSM YCSB HyperDex Run A -------------------------------
export LD_LIBRARY_PATH=/usr/local/lib
nohup echo alohomora | sudo -S iotop -btoqa | grep --line-buffered '/mnt/raid0/flsm/hyperdex_data_flsm_ycsb11_a' > ycsb"$run"_hyperdex/iotop_flsm_runa_10M$run.log &
date
./bin/ycsb run hyperdex -P workloads/workloada -p recordcount=20000000 -p operationcount=10000000 > ycsb"$run"_hyperdex/flsm_runa_10M$run.log
date
echo alohomora | sudo -S kill `pgrep iotop`
echo -------------------------------------------------------------------------------------------

echo Sleeping for 10 seconds . . . 
sleep 10

echo ------------------------------ FLSM YCSB HyperDex Run B -------------------------------
export LD_LIBRARY_PATH=/usr/local/lib
nohup echo alohomora | sudo -S iotop -btoqa | grep --line-buffered '/mnt/raid0/flsm/hyperdex_data_flsm_ycsb11_a' > ycsb"$run"_hyperdex/iotop_flsm_runb_10M$run.log &
date
./bin/ycsb run hyperdex -P workloads/workloadb -p recordcount=20000000 -p operationcount=10000000 > ycsb"$run"_hyperdex/flsm_runb_10M$run.log
date
echo alohomora | sudo -S kill `pgrep iotop`
echo -------------------------------------------------------------------------------------------

echo Sleeping for 10 seconds . . . 
sleep 10

echo ------------------------------ FLSM YCSB HyperDex Run C -------------------------------
export LD_LIBRARY_PATH=/usr/local/lib
nohup echo alohomora | sudo -S iotop -btoqa | grep --line-buffered '/mnt/raid0/flsm/hyperdex_data_flsm_ycsb11_a' > ycsb"$run"_hyperdex/iotop_flsm_runc_10M$run.log &
date
./bin/ycsb run hyperdex -P workloads/workloadc -p recordcount=20000000 -p operationcount=10000000 > ycsb"$run"_hyperdex/flsm_runc_10M$run.log
date
echo alohomora | sudo -S kill `pgrep iotop`
echo -------------------------------------------------------------------------------------------

echo Sleeping for 10 seconds . . . 
sleep 10

echo ------------------------------ FLSM YCSB HyperDex Run D -------------------------------
export LD_LIBRARY_PATH=/usr/local/lib
nohup echo alohomora | sudo -S iotop -btoqa | grep --line-buffered '/mnt/raid0/flsm/hyperdex_data_flsm_ycsb11_a' > ycsb"$run"_hyperdex/iotop_flsm_rund_10M$run.log &
date
./bin/ycsb run hyperdex -P workloads/workloadd -p recordcount=20000000 -p operationcount=10000000 > ycsb"$run"_hyperdex/flsm_rund_10M$run.log
date
echo alohomora | sudo -S kill `pgrep iotop`
echo -------------------------------------------------------------------------------------------

echo Sleeping for 10 seconds . . . 
sleep 10

echo ------------------------------ FLSM YCSB HyperDex Run F -------------------------------
export LD_LIBRARY_PATH=/usr/local/lib
nohup echo alohomora | sudo -S iotop -btoqa | grep --line-buffered '/mnt/raid0/flsm/hyperdex_data_flsm_ycsb11_a' > ycsb"$run"_hyperdex/iotop_flsm_runf_10M$run.log &
date
./bin/ycsb run hyperdex -P workloads/workloadf -p recordcount=20000000 -p operationcount=10000000 > ycsb"$run"_hyperdex/flsm_runf_10M$run.log
date
echo alohomora | sudo -S kill `pgrep iotop`
echo -------------------------------------------------------------------------------------------


