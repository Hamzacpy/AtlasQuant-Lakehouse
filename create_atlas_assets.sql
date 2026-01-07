-- File: db/core/001_create_assets_table.sql
-- Purpose: Master reference table for financial instruments (SCD Type 2)
-- Author: Hamzacpy

BEGIN;

CREATE SCHEMA IF NOT EXISTS atlas;

CREATE TABLE IF NOT EXISTS atlas.assets (
    asset_id        BIGSERIAL PRIMARY KEY,

    asset_type      VARCHAR(30) NOT NULL,       -- EQUITY, OPTION, FUTURE, BOND, FX
    asset_name      TEXT NOT NULL,               -- Business name (e.g. Apple Inc.)

    ticker          VARCHAR(20),                 -- AAPL, MSFT
    isin            VARCHAR(12),
    exchange        VARCHAR(10),                 -- XNAS, XPAR
    currency        VARCHAR(3) NOT NULL,         -- ISO 4217

    valid_from      DATE NOT NULL,
    valid_to        DATE,
    is_current      BOOLEAN NOT NULL DEFAULT true,

    created_at      TIMESTAMPTZ NOT NULL DEFAULT now(),

    CONSTRAINT chk_valid_dates
        CHECK (valid_to IS NULL OR valid_to > valid_from)
);

CREATE INDEX idx_assets_ticker_current
    ON atlas.assets (ticker)
    WHERE is_current = true;

CREATE INDEX idx_assets_isin_current
    ON atlas.assets (isin)
    WHERE is_current = true;

COMMIT;
