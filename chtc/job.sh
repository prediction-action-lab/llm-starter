#!/bin/bash

pid=$1  # ranges from 0 to num_commands*num_jobs-1 
step=$2 # ranges from 0 to num_jobs-1
#cmd=`tr '*' ' ' <<< $3` # replace * with space
#echo $cmd

export HOME=$_CONDOR_SCRATCH_DIR
export STAGE=/staging/ncorrado
export TRANSFORMERS_CACHE=$_CONDOR_SCRATCH_DIR/models
export HF_DATASETS_CACHE=$_CONDOR_SCRATCH_DIR/datasets
export HF_MODULES_CACHE=$_CONDOR_SCRATCH_DIR/modules
export HF_METRICS_CACHE=$_CONDOR_SCRATCH_DIR/metrics
export HF_HOME=$_CONDOR_SCRATCH_DIR/hf_home

export USER=condor_user # uuid issues when using vllm with chtc
export CUDA_VISIBLE_DEVICES=0,1,2,3,4,5,6,7 # on CHTC machines, gpu names are *not* the usual 0-7 by default, so we rename them here
export TORCHINDUCTOR_CACHE_DIR=$_CONDOR_SCRATCH_DIR/torch_cache
export TORCH_COMPILE_CACHE=$_CONDOR_SCRATCH_DIR/torch_compile_cache
export XDG_CACHE_HOME=$_CONDOR_SCRATCH_DIR/xdg_cache
export XDG_CONFIG_HOME=$_CONDOR_SCRATCH_DIR/xdg_config
export _USAGE_STATS_JSON_PATH=$_CONDOR_SCRATCH_DIR/vllm_usage
export VLLM_USAGE_DISABLE=1

export VLLM_ATTENTION_BACKEND=FLASH_ATTN
export NCCL_P2P_DISABLE=1
export OUTLINES_CACHE_DIR='/tmp/.outlines'
export RAY_TMPDIR=/tmp/ray_$USER

# fetch code from /staging/
CODENAME=llm-starter
cp /staging/ncorrado/${CODENAME}.tar.gz .
tar -xzf ${CODENAME}.tar.gz
rm ${CODENAME}.tar.gz
cd ${CODENAME}

#wandb login <your wandb key>
#huggingface-cli login --token <your hf token>

export PYTHONPATH=.:$PYTHONPATH
pip install -e verl

#$cmd