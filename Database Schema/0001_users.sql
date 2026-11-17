-- KitchenX Hire — Prototype Database Schema
-- Table: users (shared identity for all 3 roles)

CREATE TABLE IF NOT EXISTS users (
    id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    full_name       TEXT NOT NULL,
    phone_number    TEXT UNIQUE,
    email           TEXT UNIQUE,
    password_hash   TEXT,
    role            TEXT NOT NULL CHECK (role IN ('JOB_SEEKER', 'RECRUITER', 'ADMIN')),
    created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    deleted_at      TIMESTAMPTZ
);

CREATE UNIQUE INDEX IF NOT EXISTS idx_users_phone_active
    ON users (phone_number) WHERE deleted_at IS NULL;
