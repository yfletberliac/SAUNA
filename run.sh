 #!/bin/bash


declare -a envs=("Hopper-v2") # Choose a list of envs
declare -a seeds=("100" "101" "110" "111" "123" "456") # Choose a list of different seeds

for env in "${envs[@]}"
do
for seed in "${seeds[@]}"
do

    SAUNA_LOGDIR=logs/experiment01/$env-SAUNA-$seed SAUNA_LOG_FORMAT=csv,tensorboard,stdout python -m baselines.run --alg=ppo2 --network='mlp' --env=$env --num_timesteps=1e6 --seed $seed --num_env 1 --ent_coef=0.0 --nsteps=2048 --nminibatches=32 --noptepochs=15 --log_interval=1 --cliprange=0.2 --lr=3e-4 --sauna_thres 0.3 --sauna_coef 0.5 &

done
sleep 10
done