# [MsPrior](https://github.com/caillonantoine/msprior)

## What is it?

RAVE's architecture, when in feed forward (playing) mode, is essentially made of a (variational) encoder and a decoder. The encoder provides inputs, which are values along the axes of the trained latent space, tot he decoder to reconstruct as sound. [More info on VAEs](https://www.youtube.com/watch?v=5bA6gwo36Cw)

MsPrior does not learn how to reconstruct the sound, but rather learns sequences of values from the encoder. As such, it is an addition to a trained RAVE model.

## What to expect from it

Typically, one can simply expect heightened "coherence" of the model. By that I mean that the sound quality will remain unchanged, but sequences of sound may be closer related to the input data.

For example, take a model trained on simple speech. Original model output may resemble simple syllables, while a using MsPrior may help the model produce word-like strings of the same syllables with a slightly more familiar cadence.

## How to use it

One can train MsPrior atop their model once it is done training and is exported. It uses the exported model and the data it was trained on, and includes preprocessing, training, and exporting phases.

Refer to the dedicated section in the scripts folder, or the [source repository](https://github.com/caillonantoine/msprior).

## Additional notes

-Only works with mono (--channels=1), which happens to be default for training RAVE models

-Do not export your original model with the --streaming flag

-MsPrior training is typically quite short (10k steps), a few minutes on an HPC.