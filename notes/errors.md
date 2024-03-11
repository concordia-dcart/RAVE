# Errors
Just a list of errors encountered and how they were fixed.

**Error:** FileNotFoundError: [Errno 2] No such file or directory: '/localscratch/tpeschl.45576356.0/processed/metadata.yaml'
**Context:** Preprocessing dataset
**Fix:** Make sure you end the path to your processed dataset with '/'. Otherwise, RAVE will just concatenate filenames to it, failing to add processed data at the right place.