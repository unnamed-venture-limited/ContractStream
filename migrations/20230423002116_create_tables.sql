-- Add migration script here
 CREATE EXTENSION pgcrypto;

CREATE TABLE IF NOT EXISTS Users (
    username VARCHAR(255) UNIQUE NOT NULL,
    user_id SERIAL PRIMARY KEY,
    password_digest VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS Jobs (
    job_id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    website VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    budget NUMERIC NULL,
    hourly NUMERIC NULL,
    post_url VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS Proposals (
    proposal_id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES Users(user_id) NOT NULL,
    job_id INTEGER REFERENCES Jobs(job_id) NOT NULL,
    proposal TEXT
);

CREATE TABLE IF NOT EXISTS DecidedJobs (
    user_id INTEGER REFERENCES Users(user_id),
    job_id INTEGER REFERENCES Jobs(job_id),
    proposal_id INTEGER REFERENCES Proposals(proposal_id),
    accepted BOOLEAN,
    PRIMARY KEY (user_id, job_id)
);

CREATE TABLE IF NOT EXISTS PendingJobs (
    user_id INTEGER REFERENCES Users(user_id),
    job_id INTEGER REFERENCES Jobs(job_id),
    proposal_id INTEGER REFERENCES Proposals(proposal_id),
    PRIMARY KEY (user_id, job_id)
);

CREATE TABLE IF NOT EXISTS KMeansClasses (
    user_id INTEGER REFERENCES Users(user_id),
    kmeans_classes INTEGER[],
    job_ids INTEGER[],
    PRIMARY KEY (user_id)
);

CREATE TABLE IF NOT EXISTS Resumes (
    resume_id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES Users(user_id) NOT NULL,
    resume_text TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS SearchContext (
    context_id SERIAL PRIMARY KEY,
    resume_id INTEGER REFERENCES Resumes(resume_id) NOT NULL,
    keywords varchar(255)[] default ARRAY[]::varchar[] NOT NULL,
    user_id INTEGER REFERENCES Users(user_id) NOT NULL
);

