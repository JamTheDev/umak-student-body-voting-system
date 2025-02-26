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
