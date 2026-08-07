# U.S. Supply Chain Resilience After Port Disruptions

Reproducible research code for studying how U.S. commodity import flows reroute
and recover after extreme-weather disruptions at major ports.

## Research workflow

1. Ingest monthly U.S. Census trade data and NOAA storm-event data.
2. Standardize port, commodity, country, and time identifiers.
3. Construct the monthly Port x HS4 analytical panel.
4. Build event-specific stacks using pre-defined disruption criteria.
5. Estimate disruption, rerouting, recovery, and resilience outcomes.
6. Evaluate recovery prediction with leave-one-event-out validation.

## Quick start

```bash
uv sync --extra dev
uv run pytest
```

Copy `.env.example` to `.env` if a data source requires credentials. Raw and
processed data are deliberately excluded from Git; see `data/README.md`.

## Main commands

```bash
make install       # install the Python environment
make test          # run unit tests
make lint          # check formatting and code quality
make reproduce     # run the complete pipeline (once targets are implemented)
```

## Repository map

- `configs/`: treatment rules, event windows, ports, and model settings
- `data/`: local raw, intermediate, processed, and external data
- `src/supply_chain_resilience/`: reusable research code
- `scripts/`: thin command-line entry points
- `notebooks/`: exploration and diagnostics only
- `tests/`: data-contract, leakage, and transformation tests
- `outputs/`: generated figures, tables, models, and diagnostics
- `paper/`: manuscript and submission files
- `docs/`: data dictionary and methodological decisions

