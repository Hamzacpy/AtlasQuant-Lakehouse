"""
Script de seed des assets de référence -- ( un bootstrap initial)

Objectif : - > 

- Initialiser un univers minimal d’actifs financiers dans la base Atlas
- Remplir le référentiel métier `atlas.assets`
- Créer le mapping des identifiants source (Yahoo Finance) dans `atlas.asset_identifiers`

"""

import psycopg
import os
from dotenv import load_dotenv
from pathlib import Path

### Load environment variables from .env file
env_path = Path('.') / '.env'
load_dotenv(dotenv_path=env_path)
##-------------------------------------------##
# CONFIGURATION DE LA CONNEXION BASE DE DONNEES
##-------------------------------------------##

DB_CONFIG = {
    "dbname" : os.getenv("DB_NAME", "votre_db"),
    "user" : os.getenv("DB_USER", "postgres"),
    "password" : os.getenv("DB_PASSWORD", "votre_password"),
    "host" : os.getenv("DB_HOST", "127.0.0.1"),
    "port" : os.getenv("DB_PORT", ""),
     "sslmode": "require"
    ## "connect_timeout": 10  # FORCE le script à s'arrêter après 3s s'il ne trouve rien
}

##------------------------------------------------------------------------##
##--------- UNIVERS D'ASSETS A SEEDER - minimal d’assets (contrôlé) ---------##
##------------------------------------------------------------------------##

# ---------------------------------------------------------------------
# Univers minimal d’assets (contrôlé)
# ---------------------------------------------------------------------

ASSETS = [
    {
        "asset_type": "EQUITY",
        "asset_name": "Apple Inc.",
        "ticker": "AAPL",
        "isin": "US0378331005",
        "exchange": "XNAS",
        "currency": "USD",
        "valid_from": "1980-12-12",
        "source_symbol": "AAPL",
    },
    {
        "asset_type": "EQUITY",
        "asset_name": "Microsoft Corp.",
        "ticker": "MSFT",
        "isin": "US5949181045",
        "exchange": "XNAS",
        "currency": "USD",
        "valid_from": "1986-03-13",
        "source_symbol": "MSFT",
    },
    {
        "asset_type": "EQUITY",
        "asset_name": "Amazon.com Inc.",
        "ticker": "AMZN",
        "isin": "US0231351067",
        "exchange": "XNAS",
        "currency": "USD",
        "valid_from": "1997-05-15",
        "source_symbol": "AMZN",
    },
    {
        "asset_type": "EQUITY",
        "asset_name": "Tesla Inc.",
        "ticker": "TSLA",
        "isin": "US88160R1014",
        "exchange": "XNAS",
        "currency": "USD",
        "valid_from": "2010-06-29",
        "source_symbol": "TSLA",
    },
    {
        "asset_type": "EQUITY",
        "asset_name": "SPDR S&P 500 ETF Trust",
        "ticker": "SPY",
        "isin": "US78462F1030",
        "exchange": "ARCX",
        "currency": "USD",
        "valid_from": "1993-01-29",
        "source_symbol": "SPY",
    },
]


# ---------------------------------------------------------------------
# --------------------------Seed execution-----------------------------
# ---------------------------------------------------------------------

def main() -> None:
    print("Démarrage du seed des assets Atlas...")

    with psycopg.connect(**DB_CONFIG) as conn:
        with conn.cursor() as cur:
            for asset in ASSETS:
                # Insertion dans atlas.assets
                cur.execute(
                    """
                    INSERT INTO atlas.assets (
                        asset_type,
                        asset_name,
                        ticker,
                        isin,
                        exchange,
                        currency,
                        valid_from,
                        is_current
                    )
                    VALUES (%s,%s,%s,%s,%s,%s,%s,true)
                    RETURNING asset_id;
                    """,
                    (
                        asset["asset_type"],
                        asset["asset_name"],
                        asset["ticker"],
                        asset["isin"],
                        asset["exchange"],
                        asset["currency"],
                        asset["valid_from"],
                    ),
                )

                asset_id = cur.fetchone()[0] # Récupération de l'asset_id inséré pour le mapping / clé étrangere

                # Insertion du mapping Yahoo Finance
                
                cur.execute(
                    """
                    INSERT INTO atlas.asset_identifiers (
                        asset_id,
                        source,
                        source_symbol,
                        valid_from
                    )
                    VALUES (%s, 'YAHOO_FINANCE', %s, %s);
                    """,
                    (
                        asset_id,
                        asset["source_symbol"],
                        asset["valid_from"],
                    ),
                )

        conn.commit()

    print("Seed terminé avec succès : assets et mappings créés.")


if __name__ == "__main__":
    main()
    

