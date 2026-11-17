-- KitchenX Hire — Prototype Database Schema
-- Table: recruiter_profiles

CREATE TABLE IF NOT EXISTS recruiter_profiles (
    id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id         UUID NOT NULL UNIQUE REFERENCES users (id),
    business_id     UUID NOT NULL REFERENCES businesses (id),
    designation     TEXT,
    created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    deleted_at      TIMESTAMPTZ
);
