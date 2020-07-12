# Only Relevant Information Matters:</br>Filtering Out Noisy Samples to Boost RL
This repository is the official implementation of [SAUNA]() accepted at IJCAI 2020.

## Implementation details
<img src="https://render.githubusercontent.com/render/math?math=\mathcal{V}^{ex}"> *function* is implemented [here](https://github.com/yfletberliac/SAUNA/blob/142a4e7e9eb63e6ab9f87877a01dfc6eeb6e3f85/baselines/common/policies.py#L66) in `baselines/common/policies.py` while its associated *loss* is computed [here](https://github.com/yfletberliac/SAUNA/blob/142a4e7e9eb63e6ab9f87877a01dfc6eeb6e3f85/baselines/ppo2/model.py#L90) in `baselines/ppo2/model.py`. Other dependencies exist in the code.

## Prerequisites
`SAUNA` requires python3 (>=3.5).
    
## Virtual environment
From the general python package sanity perspective, it is a good idea to use virtual environments (virtualenvs) to make sure packages from different projects do not interfere with each other. You can install virtualenv (which is itself a pip package) via
```bash
pip install virtualenv
```
Virtualenvs are essentially folders that have copies of python executable and all python packages.
To create a virtualenv called venv with python3, one runs 
```bash
virtualenv /path/to/venv --python=python3
```
To activate a virtualenv: 
```
. /path/to/venv/bin/activate
```

## Installation
- Clone the repo and cd into it:
    ```bash
    git clone https://github.com/yfletberliac/SAUNA.git
    cd SAUNA
    ```
- If you don't have TensorFlow installed already, install your favourite flavor of TensorFlow. Version `1.15.2` is preferred. In most cases, 
    ```bash 
    pip install tensorflow-gpu # if you have a CUDA-compatible gpu and proper drivers
    ```
    or 
    ```bash
    pip install tensorflow
    ```
    should be sufficient. Refer to [TensorFlow installation guide](https://www.tensorflow.org/install/)
    for more details. 

- Install `SAUNA` package
    ```bash
    pip install -e .
    ```
    
### MuJoCo
[MuJoCo](http://www.mujoco.org) (multi-joint dynamics in contact) physics simulator is proprietary and requires binaries and a license (temporary 30-day license can be obtained from [www.mujoco.org](http://www.mujoco.org)). Instructions on setting up MuJoCo can be found [here](https://github.com/openai/mujoco-py).

## Training models
You can start a simulation on the environment of your choice (eg. HalfCheetah-v2) like so:
```
python -m baselines.run --alg=ppo2 --env=HalfCheetah-v2 --num_timesteps=1e6 --sauna_thres 0.3 --sauna_coef 0.5
```
You can set the arguments `--sauna_thres` (filtering threshold) and `--sauna_coef` (loss function coefficient) to the desired value. Defaults values are respectivilely 0.3 and 0.5.

To set the number of parallel environments for your machine use `--num_env`. Defaults to 1 for MuJoCo tasks.

### Run sets of experiments
To run sets of experiments (different envs & different seeds):
```
bash run.sh
```

## Saving, loading and playing models
To save:
```bash
python -m baselines.run --alg=ppo2 --env=HalfCheetah-v2 --num_timesteps=1e6 --save_path=models/mujoco/halfcheetah_1M_SAUNA
```
To load:
```bash
python -m baselines.run --alg=ppo2 --env=HalfCheetah-v2 --num_timesteps=1e6 --load_path=~/models/halfcheetah_1M_SAUNA
```
To play:
```bash
python -m baselines.run --alg=ppo2 --env=HalfCheetah-v2 --num_timesteps=0 --load_path=~/models/halfcheetah_1M_SAUNA --play
```

## Visualize and plot the results (with multiple seeds)
Run a single-seeded experiment and save logs in e.g. `logs/halfcheetah_1M_SAUNA`:
```bash
SAUNA_LOGDIR=logs/halfcheetah_1M_SAUNA/seed101 SAUNA_LOG_FORMAT=csv,tensorboard,stdout python -m baselines.run --alg=ppo2 --env=HalfCheetah-v2 --num_timesteps=1e6 --save_path=~/models/halfcheetah_1M_SAUNA --seed 101
```
Run multi-seeded experiments and save logs in e.g. `logs/halfcheetah_1M_SAUNA`:
```
bash run.sh
```
You can visualize the logs on TensorBoard while training. When all experiments are finished, set `plot.py` path to `logs/halfcheetah_1M_SAUNA` and execute:
```python
python plot.py
```

## Original code
The code has been forked from [OpenAI baselines](https://github.com/openai/baselines).

## Reference
```
@inproceedings{ijcai2020-376,
  title     = {Only Relevant Information Matters: Filtering Out Noisy Samples To Boost RL},
  author    = {Flet-Berliac, Yannis and Preux, Philippe},
  booktitle = {Proceedings of the Twenty-Ninth International Joint Conference on
               Artificial Intelligence, {IJCAI-20}},
  publisher = {International Joint Conferences on Artificial Intelligence Organization},             
  pages     = {2711--2717},
  year      = {2020},
  month     = {7},
  doi       = {10.24963/ijcai.2020/376},
  url       = {https://doi.org/10.24963/ijcai.2020/376},
}
```
