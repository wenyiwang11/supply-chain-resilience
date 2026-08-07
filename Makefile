.PHONY: install test lint reproduce

install:
	uv sync --extra dev

test:
	uv run pytest

lint:
	uv run ruff check .

reproduce:
	uv run python scripts/reproduce_all.py

