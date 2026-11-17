-- KitchenX Hire — Prototype Database Schema
-- Table: job_categories (lookup)

CREATE TABLE IF NOT EXISTS job_categories (
    id          SERIAL PRIMARY KEY,
    name        TEXT NOT NULL UNIQUE,
    created_at  TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

INSERT INTO job_categories (name)
VALUES
    ('KITCHEN_HELPER'),
    ('DISHWASHER'),
    ('COOK'),
    ('CLEANER'),
    ('WAITER')
ON CONFLICT (name) DO NOTHING;
