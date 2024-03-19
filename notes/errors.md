# Errors and Issues
Just a list of errors encountered and how they were fixed.

**Error:** FileNotFoundError: [Errno 2] No such file or directory: '/localscratch/tpeschl.45576356.0/processed/metadata.yaml'
**Context:** Preprocessing dataset
**Fix:** Make sure you end the path to your processed dataset with '/'. Otherwise, RAVE will just concatenate filenames to it, failing to add processed data at the right place.

**Error:** Training stuck at "Validation dataloader"
**Context:** RAVE is unable to write a checkpoint file
**Fix:** TBD

**Error:** /home/tpeschl/.local/lib/python3.10/site-packages/torch/nn/init.py:405: UserWarning: Initializing zero-element tensors is a no-op
  warnings.warn("Initializing zero-element tensors is a no-op")
**Context:** RAVE seems to not locate the dataset, providing null input to
**Fix:** TBD