# Notebooks

Use notebooks for exploration, event validation, and diagnostics. Official
figures, tables, and datasets should be produced by code in `src/` and thin
entry points in `scripts/` so the analysis remains reproducible.

- `ais_daily_download_2010_2025.ipynb`: discovers the NOAA Marine Cadastre
  archive, performs guarded and resumable AIS downloads, handles both legacy
  file geodatabases and daily CSV ZIPs, spatially clips messages, and writes
  point-level Parquet extracts plus a daily activity diagnostic.
