-- KitchenX Hire — Prototype Database Schema
-- Table: job_seeker_profiles

CREATE TABLE IF NOT EXISTS job_seeker_profiles (
    id                  UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id             UUID NOT NULL UNIQUE REFERENCES users (id),
    city                TEXT,
    experience_years    INTEGER NOT NULL DEFAULT 0,
    skills              TEXT[] NOT NULL DEFAULT '{}',
    created_at          TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at          TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    deleted_at          TIMESTAMPTZ
);
