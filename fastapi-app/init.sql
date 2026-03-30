-- PostgreSQL initialization script
-- Tables are auto-created by SQLAlchemy on app startup.
-- Add any seed data or extensions here.

-- Enable UUID extension (optional, for future use)
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Log init
DO $$ BEGIN
  RAISE NOTICE 'Database initialized successfully.';
END $$;
