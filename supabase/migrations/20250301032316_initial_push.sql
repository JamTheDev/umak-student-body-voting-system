-- Create table for elections
CREATE TABLE elections (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name TEXT NOT NULL,
    description TEXT,
    start_time TIMESTAMP NOT NULL,
    end_time TIMESTAMP NOT NULL,
    created_at TIMESTAMP DEFAULT NOW()
);

-- Create table for positions
CREATE TABLE positions (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    election_id UUID REFERENCES elections(id),
    name TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT NOW()
);

-- Create table for partylists
CREATE TABLE partylists (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name TEXT NOT NULL,
    abbreviation TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT NOW()
);

-- Create table for colleges
CREATE TABLE colleges (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    acronym TEXT NOT NULL,
    full_name TEXT NOT NULL,
    logo_url TEXT,
    created_at TIMESTAMP DEFAULT NOW()
);

-- Create table for candidates
CREATE TABLE candidates (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    election_id UUID REFERENCES elections(id),
    position_id UUID REFERENCES positions(id),
    name TEXT NOT NULL,
    platform TEXT,
    profile_picture TEXT,
    partylist_id UUID REFERENCES partylists(id),
    college_id UUID REFERENCES colleges(id),
    created_at TIMESTAMP DEFAULT NOW()
);

-- Create table for candidate experience
CREATE TABLE candidate_experience (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    candidate_id UUID REFERENCES candidates(id),
    organization TEXT NOT NULL,
    position TEXT NOT NULL,
    start_date DATE,
    end_date DATE,
    created_at TIMESTAMP DEFAULT NOW()
);

-- Create table for students
CREATE TABLE students (
    student_id TEXT PRIMARY KEY,
    created_at TIMESTAMP DEFAULT NOW()
);

-- Create table for votes
CREATE TABLE votes (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    election_id UUID REFERENCES elections(id),
    student_id TEXT REFERENCES students(student_id),
    candidate_id UUID REFERENCES candidates(id),
    created_at TIMESTAMP DEFAULT NOW()
);