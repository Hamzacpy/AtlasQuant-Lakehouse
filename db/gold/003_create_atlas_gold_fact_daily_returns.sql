CREATE TABLE atlas_gold.fact_daily_returns (
    asset_id    BIGINT NOT NULL,
    price_date  DATE NOT NULL,

    close_price DECIMAL(18,6) NOT NULL,
    return_log  DECIMAL(18,10),

    CONSTRAINT pk_fact_daily_returns
        PRIMARY KEY (asset_id, price_date),

    CONSTRAINT fk_fact_returns_asset
        FOREIGN KEY (asset_id)
        REFERENCES atlas.assets(asset_id)
);
