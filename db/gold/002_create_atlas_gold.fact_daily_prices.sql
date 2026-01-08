CREATE TABLE atlas_gold.daily_prices (
    asset_id    BIGINT NOT NULL,
    price_date  DATE NOT NULL,

    open_price  DECIMAL(18,6),
    high_price  DECIMAL(18,6),
    low_price   DECIMAL(18,6),
    close_price DECIMAL(18,6),
    volume      BIGINT,
    CONSTRAINT  pk_fact_daily_prices PRIMARY KEY (asset_id, price_date), -- unicité de asset_id et price_id
    CONSTRAINT  fk_fact_prices_asset FOREIGN KEY (asset_id) REFERENCES atlas.assets(asset_id) ON DELETE RESTRICT 
);

