-- File: db/bronze/001_create_bronze_tables.sql
--- Purpose: Create Bronze schema and Yahoo raw table
---- Author: Hamzacpy

BEGIN;

CREATE SCHEMA IF NOT EXISTS atlas_bronze;

CREATE TABLE IF NOT EXISTS atlas_bronze.yahoo_prices_raw (
    raw_id            BIGSERIAL PRIMARY KEY,
    source            TEXT NOT NULL DEFAULT 'YAHOO_FINANCE',
    raw_payload       JSONB NOT NULL,
    symbol VARCHAR(20) NOT NULL,
    ingestion_run_id  BIGINT NOT NULL,
    ingested_at       TIMESTAMPTZ NOT NULL DEFAULT now()
);

COMMIT;
CREATE INDEX idx_yahoo_raw_ingestion_ts
ON atlas_bronze.yahoo_prices_raw (ingestion_run_id);
CREATE INDEX idx_yahoo_raw_symbol
ON atlas_bronze.yahoo_prices_raw (symbol);