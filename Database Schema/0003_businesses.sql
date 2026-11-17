-- KitchenX Hire — Prototype Database Schema
-- Table: businesses (restaurants / outlets that hire)

CREATE TABLE IF NOT EXISTS businesses (
    id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    owner_user_id   UUID NOT NULL REFERENCES users (id),
    business_name   TEXT NOT NULL,
    business_type   TEXT,
    city            TEXT,
    address         TEXT,
    status          TEXT NOT NULL DEFAULT 'APPROVED' CHECK (status IN ('PENDING', 'APPROVED', 'REJECTED')),
    created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    deleted_at      TIMESTAMPTZ
);
