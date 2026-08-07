# Data

Data files are stored locally and are not committed to Git.

- `raw/`: immutable source downloads organized by provider
- `interim/`: standardized data before analytical aggregation
- `processed/`: analysis-ready panels and event stacks
- `external/`: manually collected validation records and crosswalks

Each download pipeline should record the source URL, retrieval date, release or
vintage, file checksum, and applicable license. Transformations must never
modify files in `raw/`.

