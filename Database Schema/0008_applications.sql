-- KitchenX Hire — Prototype Database Schema
-- Table: applications

CREATE TABLE IF NOT EXISTS applications (
    id                  UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    job_id              UUID NOT NULL REFERENCES jobs (id),
    job_seeker_id       UUID NOT NULL REFERENCES job_seeker_profiles (id),
    resume_id           UUID REFERENCES resumes (id),
    status              TEXT NOT NULL DEFAULT 'APPLIED'
                            CHECK (status IN ('APPLIED', 'SHORTLISTED', 'ACCEPTED', 'REJECTED', 'WITHDRAWN')),
    applicant_note      TEXT,
    recruiter_notes     TEXT,
    applied_at          TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at          TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    deleted_at          TIMESTAMPTZ,
    UNIQUE (job_id, job_seeker_id)
);

CREATE INDEX IF NOT EXISTS idx_applications_job_id ON applications (job_id) WHERE deleted_at IS NULL;
CREATE INDEX IF NOT EXISTS idx_applications_job_seeker_id ON applications (job_seeker_id) WHERE deleted_at IS NULL;
