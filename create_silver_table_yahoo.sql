-- File: db/silver/001_create_silver_market_tables.sql
-- Purpose: Create Silver market prices table (equities spot, daily)
-- Author: Hamzacpy

BEGIN;

CREATE SCHEMA IF NOT EXISTS atlas_silver;

CREATE TABLE IF NOT EXISTS atlas_silver.market_prices_equity (
    asset_id    BIGINT NOT NULL,
    price_date  DATE NOT NULL,
    open_price  DECIMAL(18,6),
    high_price  DECIMAL(18,6),
    low_price   DECIMAL(18,6),
    close_price DECIMAL(18,6),
    volume      BIGINT,
    PRIMARY KEY (asset_id, price_date),
    CONSTRAINT fk_market_prices_asset
        FOREIGN KEY (asset_id)
        REFERENCES atlas.assets(asset_id)
);

COMMIT;
