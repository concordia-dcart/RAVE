## Info

**Infrastructure:** DRAC - Beluga
**Dataset:** percussive (mainly early 2000's hip hop) and melodic (DSBM) (separate training)
**Template(s):** vanilla_v2
**Flags:** no unusual flags

## Status

training

## Objective

compare training results through time of datasets of percussive and melodic nature.

## Methodology

Models of each dataset will be analyzed through tensorboard at 500k, 1m, 3m steps with only phase 1 training. respective checkpoints are saved for phase 2 training, where we will again analyze results on each at 500k, 1m, 3m steps.
Due to previous experience, my intuition is that percussive data is learned much faster than melodic data by the RAVE architecture.
However, I am unsure whether the phase 2 of training makes up for that.

## Conclusion

state what has been learned from test

## Issues

slowed down by issues regarding training multiple models at once
First attempt: there seems to be an issue with loading the python environment. Froze before training.

Second attempt: Trying with newly provided wheel for rave v2.3.1, avoiding the need of a requirements list.
/home/tpeschl/.local/lib/python3.10/site-packages/torch/nn/init.py:405: UserWarning: Initializing zero-element tensors is a no-op
  warnings.warn("Initializing zero-element tensors is a no-op")
  is this an error related to wrong dataset path?

## Solutions

state solutions here, if any

## Documentation

images, ideas, ...

## Notes