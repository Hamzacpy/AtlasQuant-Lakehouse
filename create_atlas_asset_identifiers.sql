
BEGIN;

CREATE TABLE IF NOT EXISTS atlas.asset_identifiers (
    identifier_id   BIGSERIAL PRIMARY KEY,

    asset_id        BIGINT NOT NULL,
    source          TEXT NOT NULL,
    source_symbol   VARCHAR(20) NOT NULL,

    valid_from      DATE NOT NULL,
    valid_to        DATE,

    created_at      TIMESTAMPTZ NOT NULL DEFAULT now(),

    CONSTRAINT fk_asset_identifier_asset
        FOREIGN KEY (asset_id)
        REFERENCES atlas.assets(asset_id),

    CONSTRAINT chk_identifier_validity
        CHECK (valid_to IS NULL OR valid_to > valid_from),

    CONSTRAINT uq_identifier
        UNIQUE (source, source_symbol, valid_from)
);

CREATE INDEX idx_asset_identifiers_lookup
    ON atlas.asset_identifiers (source, source_symbol)
    WHERE valid_to IS NULL;

COMMIT;
