-- INSERT INTO atlas.assets (
--     asset_type,
--     asset_name,
--     ticker,
--     isin,
--     exchange,
--     currency,
--     valid_from,
--     is_current
-- )
-- VALUES
-- ('EQUITY', 'Apple Inc.', 'AAPL', 'US0378331005', 'XNAS', 'USD', '1980-12-12', true),
-- ('EQUITY', 'Microsoft Corp.', 'MSFT', 'US5949181045', 'XNAS', 'USD', '1986-03-13', true),
-- ('EQUITY', 'SPDR S&P 500 ETF', 'SPY', 'US78462F1030', 'ARCX', 'USD', '1993-01-29', true);

-- SELECT * FROM atlas.assets;
-- INSERT INTO atlas_silver.market_prices_equity (
--     asset_id,
--     price_date,
--     open_price,
--     high_price,
--     low_price,
--     close_price,
--     volume
-- )
-- VALUES (
--     1,
--     '2024-01-02',
--     180.00,
--     182.50,
--     178.90,
--     181.75,
--     85000000
-- );
-- SELECT * FROM atlas_silver.market_prices_equity;
-- SELECT a.ticker , p.price_date , p.close_price FROM atlas.assets a 
-- JOIN atlas_silver.market_prices_equity p ON a.asset_id = p.asset_id

-- CREATE INDEX idx_yahoo_raw_symbol
--     ON atlas_bronze.yahoo_prices_raw (symbol);


-- ALTER TABLE atlas_bronze.yahoo_prices_raw
-- UPDATE COLUMN symbol VARCHAR(20) NOT NULL;

-- CREATE INDEX idx_yahoo_raw_ingestion_ts
-- ON atlas_bronze.yahoo_prices_raw (ingestion_run_id);
-- CREATE INDEX idx_yahoo_raw_symbol
-- ON atlas_bronze.yahoo_prices_raw (symbol);

