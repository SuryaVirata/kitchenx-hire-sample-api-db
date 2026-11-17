-- KitchenX Hire — Prototype Database Schema
-- Table: jobs

CREATE TABLE IF NOT EXISTS jobs (
    id                  UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    business_id         UUID NOT NULL REFERENCES businesses (id),
    posted_by_user_id   UUID NOT NULL REFERENCES users (id),
    category_id         INTEGER REFERENCES job_categories (id),
    title               TEXT NOT NULL,
    description         TEXT,
    city                TEXT,
    pay_amount          INTEGER,
    pay_type            TEXT CHECK (pay_type IN ('MONTHLY', 'DAILY', 'HOURLY')),
    status              TEXT NOT NULL DEFAULT 'OPEN' CHECK (status IN ('DRAFT', 'OPEN', 'CLOSED')),
    created_at          TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at          TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    deleted_at          TIMESTAMPTZ
);

CREATE INDEX IF NOT EXISTS idx_jobs_city_status ON jobs (city, status) WHERE deleted_at IS NULL;
CREATE INDEX IF NOT EXISTS idx_jobs_business_id ON jobs (business_id) WHERE deleted_at IS NULL;
