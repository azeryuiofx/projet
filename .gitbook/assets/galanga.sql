CREATE TYPE "statut_commande" AS ENUM (
  'en_attente',
  'annule',
  'en_cuisine',
  'en_livraison',
  'livre'
);

CREATE TABLE "client" (
  "id_client" SERIAL PRIMARY KEY,
  "nom_client" varchar(20),
  "prenom_client" varchar(20),
  "adresse" varchar(50),
  "id_ville" int,
  "mail" varchar,
  "date_creation" timestamp
);

CREATE TABLE "ville" (
  "id_ville" int PRIMARY KEY,
  "nom_ville" varchar(20),
  "code_postal" int(5)
);

CREATE TABLE "produit" (
  "id_produit" varchar PRIMARY KEY,
  "nom_produit" varchar,
  "desc_produit" varchar,
  "prix_produit" int,
  "tva_produit" int,
  "statut_produit" boolean DEFAULT false,
  "date_creation" datetime DEFAULT (now())
);

CREATE TABLE "TVA" (
  "id_tva" int PRIMARY KEY,
  "taux" int
);

CREATE TABLE "commande" (
  "id_commande" int PRIMARY KEY,
  "id_client" int UNIQUE NOT NULL,
  "statut_commande" statut_commande,
  "date_commande" varchar
);

CREATE TABLE "liste_commande" (
  "id_commande" int,
  "id_produit" int,
  "quantite" int DEFAULT 1
);

ALTER TABLE "client" ADD FOREIGN KEY ("id_ville") REFERENCES "ville" ("id_ville");

ALTER TABLE "produit" ADD FOREIGN KEY ("tva_produit") REFERENCES "TVA" ("id_tva");

ALTER TABLE "commande" ADD FOREIGN KEY ("id_client") REFERENCES "client" ("id_client");

ALTER TABLE "liste_commande" ADD FOREIGN KEY ("id_commande") REFERENCES "commande" ("id_commande");

ALTER TABLE "liste_commande" ADD FOREIGN KEY ("id_produit") REFERENCES "produit" ("id_produit");

COMMENT ON COLUMN "commande"."date_commande" IS 'When order created';
