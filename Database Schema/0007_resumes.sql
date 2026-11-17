-- KitchenX Hire — Prototype Database Schema
-- Table: resumes

CREATE TABLE IF NOT EXISTS resumes (
    id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    job_seeker_id   UUID NOT NULL REFERENCES job_seeker_profiles (id),
    file_name       TEXT NOT NULL,
    file_url        TEXT NOT NULL,
    uploaded_at     TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    deleted_at      TIMESTAMPTZ
);

CREATE INDEX IF NOT EXISTS idx_resumes_job_seeker_id ON resumes (job_seeker_id) WHERE deleted_at IS NULL;
