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

-- Insert sample elections
INSERT INTO elections (id, name, description, start_time, end_time) VALUES
    (uuid_generate_v4(), 'University Student Council Elections 2025', 'Annual elections for the student council.', '2025-03-01 08:00:00', '2025-03-01 18:00:00');

-- Insert sample positions
INSERT INTO positions (id, election_id, name) VALUES
    (uuid_generate_v4(), (SELECT id FROM elections LIMIT 1), 'President'),
    (uuid_generate_v4(), (SELECT id FROM elections LIMIT 1), 'Vice President'),
    (uuid_generate_v4(), (SELECT id FROM elections LIMIT 1), 'Secretary');

-- Insert sample partylists
INSERT INTO partylists (id, name, abbreviation) VALUES
    (uuid_generate_v4(), 'Progressive Student Alliance', 'PSA'),
    (uuid_generate_v4(), 'United Students Front', 'USF');

-- Insert sample colleges
INSERT INTO colleges (id, acronym, full_name, logo_url) VALUES
    (uuid_generate_v4(), 'CCIS', 'College of Computing and Information Science', 'https://example.com/logos/ccis.png'),
    (uuid_generate_v4(), 'CAS', 'College of Arts and Sciences', 'https://example.com/logos/cas.png');

-- Insert sample candidates
INSERT INTO candidates (id, election_id, position_id, name, platform, profile_picture, partylist_id, college_id) VALUES
    (uuid_generate_v4(), 
        (SELECT id FROM elections LIMIT 1), 
        (SELECT id FROM positions WHERE name = 'President' LIMIT 1), 
        'John Doe', 
        'Advocating for better student rights and transparency.', 
        'https://example.com/profiles/johndoe.png', 
        (SELECT id FROM partylists WHERE abbreviation = 'PSA' LIMIT 1),
        (SELECT id FROM colleges WHERE acronym = 'CCIS' LIMIT 1)
    ),
    (uuid_generate_v4(), 
        (SELECT id FROM elections LIMIT 1), 
        (SELECT id FROM positions WHERE name = 'Vice President' LIMIT 1), 
        'Jane Smith', 
        'Empowering students with technology and innovation.', 
        'https://example.com/profiles/janesmith.png', 
        (SELECT id FROM partylists WHERE abbreviation = 'USF' LIMIT 1),
        (SELECT id FROM colleges WHERE acronym = 'CAS' LIMIT 1)
    );

-- Insert sample candidate experience
INSERT INTO candidate_experience (id, candidate_id, organization, position, start_date, end_date) VALUES
    (uuid_generate_v4(), (SELECT id FROM candidates WHERE name = 'John Doe'), 'Tech Club', 'President', '2023-01-01', '2024-12-31'),
    (uuid_generate_v4(), (SELECT id FROM candidates WHERE name = 'Jane Smith'), 'Debate Society', 'Chairperson', '2022-01-01', NULL);

-- Insert sample students (voters)
INSERT INTO students (student_id) VALUES
    ('A12240987'),
    ('K23456789'),
    ('A34567890');

-- Insert sample votes
INSERT INTO votes (id, election_id, student_id, candidate_id) VALUES
    (uuid_generate_v4(), (SELECT id FROM elections LIMIT 1), 'A12240987', (SELECT id FROM candidates WHERE name = 'John Doe')),
    (uuid_generate_v4(), (SELECT id FROM elections LIMIT 1), 'K23456789', (SELECT id FROM candidates WHERE name = 'Jane Smith'));