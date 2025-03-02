-- Insert sample election only if it doesn't exist
INSERT INTO elections (id, name, description, start_time, end_time)
SELECT uuid_generate_v4(), 
    'University Student Council Elections 2025', 
    'Annual elections for the student council.', 
    '2025-03-01 08:00:00', 
    '2025-03-01 18:00:00'
WHERE NOT EXISTS (
  SELECT 1 FROM elections 
  WHERE name = 'University Student Council Elections 2025'
);

-- Insert sample positions only if they don't exist
INSERT INTO positions (id, election_id, name, prio)
SELECT uuid_generate_v4(), (SELECT id FROM elections WHERE name = 'University Student Council Elections 2025' LIMIT 1), 'President', 0
WHERE NOT EXISTS (
  SELECT 1 FROM positions 
  WHERE name = 'President' 
    AND election_id = (SELECT id FROM elections WHERE name = 'University Student Council Elections 2025' LIMIT 1)
);

INSERT INTO positions (id, election_id, name, prio)
SELECT uuid_generate_v4(), (SELECT id FROM elections WHERE name = 'University Student Council Elections 2025' LIMIT 1), 'Vice President', 1
WHERE NOT EXISTS (
  SELECT 1 FROM positions 
  WHERE name = 'Vice President'
    AND election_id = (SELECT id FROM elections WHERE name = 'University Student Council Elections 2025' LIMIT 1)
);

INSERT INTO positions (id, election_id, name, prio)
SELECT uuid_generate_v4(), (SELECT id FROM elections WHERE name = 'University Student Council Elections 2025' LIMIT 1), 'Secretary', 2
WHERE NOT EXISTS (
  SELECT 1 FROM positions 
  WHERE name = 'Secretary'
    AND election_id = (SELECT id FROM elections WHERE name = 'University Student Council Elections 2025' LIMIT 1)
);

INSERT INTO positions (id, election_id, name, prio)
SELECT uuid_generate_v4(), (SELECT id FROM elections WHERE name = 'University Student Council Elections 2025' LIMIT 1), 'Treasurer', 3
WHERE NOT EXISTS (
  SELECT 1 FROM positions 
  WHERE name = 'Treasurer'
    AND election_id = (SELECT id FROM elections WHERE name = 'University Student Council Elections 2025' LIMIT 1)
);

INSERT INTO positions (id, election_id, name, prio)
SELECT uuid_generate_v4(), (SELECT id FROM elections WHERE name = 'University Student Council Elections 2025' LIMIT 1), 'Auditor', 4
WHERE NOT EXISTS (
  SELECT 1 FROM positions 
  WHERE name = 'Auditor'
    AND election_id = (SELECT id FROM elections WHERE name = 'University Student Council Elections 2025' LIMIT 1)
);

INSERT INTO positions (id, election_id, name, prio)
SELECT uuid_generate_v4(), (SELECT id FROM elections WHERE name = 'University Student Council Elections 2025' LIMIT 1), 'Public Relations Officer', 5
WHERE NOT EXISTS (
  SELECT 1 FROM positions 
  WHERE name = 'Public Relations Officer'
    AND election_id = (SELECT id FROM elections WHERE name = 'University Student Council Elections 2025' LIMIT 1)
);

-- Insert sample partylists only if they don't exist
INSERT INTO partylists (id, name, abbreviation)
SELECT uuid_generate_v4(), 'Progressive Student Alliance', 'PSA'
WHERE NOT EXISTS (
  SELECT 1 FROM partylists WHERE abbreviation = 'PSA'
);

INSERT INTO partylists (id, name, abbreviation)
SELECT uuid_generate_v4(), 'United Students Front', 'USF'
WHERE NOT EXISTS (
  SELECT 1 FROM partylists WHERE abbreviation = 'USF'
);

-- Insert sample colleges only if they don't exist
INSERT INTO colleges (id, acronym, full_name, logo_url)
SELECT uuid_generate_v4(), 'CCIS', 'College of Computing and Information Science', 'https://example.com/logos/ccis.png'
WHERE NOT EXISTS (
  SELECT 1 FROM colleges WHERE acronym = 'CCIS'
);

INSERT INTO colleges (id, acronym, full_name, logo_url)
SELECT uuid_generate_v4(), 'CAS', 'College of Arts and Sciences', 'https://example.com/logos/cas.png'
WHERE NOT EXISTS (
  SELECT 1 FROM colleges WHERE acronym = 'CAS'
);

INSERT INTO colleges (id, acronym, full_name, logo_url)
SELECT uuid_generate_v4(), 'COE', 'College of Engineering', 'https://example.com/logos/coe.png'
WHERE NOT EXISTS (
  SELECT 1 FROM colleges WHERE acronym = 'COE'
);

INSERT INTO colleges (id, acronym, full_name, logo_url)
SELECT uuid_generate_v4(), 'COB', 'College of Business', 'https://example.com/logos/cob.png'
WHERE NOT EXISTS (
  SELECT 1 FROM colleges WHERE acronym = 'COB'
);

-- Insert sample candidates only if they don't exist
-- President candidates
INSERT INTO candidates (id, election_id, position_id, name, platform, profile_picture, partylist_id, college_id)
SELECT uuid_generate_v4(),
    (SELECT id FROM elections WHERE name = 'University Student Council Elections 2025' LIMIT 1),
    (SELECT id FROM positions WHERE name = 'President' AND election_id = (SELECT id FROM elections WHERE name='University Student Council Elections 2025' LIMIT 1) LIMIT 1),
    'John Doe', 
    'Advocating for better student rights and transparency.',
    'https://example.com/profiles/johndoe.png',
    (SELECT id FROM partylists WHERE abbreviation = 'PSA' LIMIT 1),
    (SELECT id FROM colleges WHERE acronym = 'CCIS' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM candidates WHERE name = 'John Doe'
);

INSERT INTO candidates (id, election_id, position_id, name, platform, profile_picture, partylist_id, college_id)
SELECT uuid_generate_v4(),
    (SELECT id FROM elections WHERE name = 'University Student Council Elections 2025' LIMIT 1),
    (SELECT id FROM positions WHERE name = 'President' AND election_id = (SELECT id FROM elections WHERE name='University Student Council Elections 2025' LIMIT 1) LIMIT 1),
    'Maria Rodriguez', 
    'Building a stronger university community through inclusivity.',
    'https://example.com/profiles/maria.png',
    (SELECT id FROM partylists WHERE abbreviation = 'USF' LIMIT 1),
    (SELECT id FROM colleges WHERE acronym = 'CAS' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM candidates WHERE name = 'Maria Rodriguez'
);

-- Vice President candidates
INSERT INTO candidates (id, election_id, position_id, name, platform, profile_picture, partylist_id, college_id)
SELECT uuid_generate_v4(),
    (SELECT id FROM elections WHERE name = 'University Student Council Elections 2025' LIMIT 1),
    (SELECT id FROM positions WHERE name = 'Vice President' AND election_id = (SELECT id FROM elections WHERE name='University Student Council Elections 2025' LIMIT 1) LIMIT 1),
    'Jane Smith', 
    'Empowering students with technology and innovation.',
    'https://example.com/profiles/janesmith.png',
    (SELECT id FROM partylists WHERE abbreviation = 'PSA' LIMIT 1),
    (SELECT id FROM colleges WHERE acronym = 'COE' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM candidates WHERE name = 'Jane Smith'
);

INSERT INTO candidates (id, election_id, position_id, name, platform, profile_picture, partylist_id, college_id)
SELECT uuid_generate_v4(),
    (SELECT id FROM elections WHERE name = 'University Student Council Elections 2025' LIMIT 1),
    (SELECT id FROM positions WHERE name = 'Vice President' AND election_id = (SELECT id FROM elections WHERE name='University Student Council Elections 2025' LIMIT 1) LIMIT 1),
    'Michael Chen', 
    'Creating more opportunities for student leadership and growth.',
    'https://example.com/profiles/michael.png',
    (SELECT id FROM partylists WHERE abbreviation = 'USF' LIMIT 1),
    (SELECT id FROM colleges WHERE acronym = 'COB' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM candidates WHERE name = 'Michael Chen'
);

-- Secretary candidates
INSERT INTO candidates (id, election_id, position_id, name, platform, profile_picture, partylist_id, college_id)
SELECT uuid_generate_v4(),
    (SELECT id FROM elections WHERE name = 'University Student Council Elections 2025' LIMIT 1),
    (SELECT id FROM positions WHERE name = 'Secretary' AND election_id = (SELECT id FROM elections WHERE name='University Student Council Elections 2025' LIMIT 1) LIMIT 1),
    'Sarah Johnson', 
    'Improving communication between administration and students.',
    'https://example.com/profiles/sarah.png',
    (SELECT id FROM partylists WHERE abbreviation = 'PSA' LIMIT 1),
    (SELECT id FROM colleges WHERE acronym = 'CAS' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM candidates WHERE name = 'Sarah Johnson'
);

INSERT INTO candidates (id, election_id, position_id, name, platform, profile_picture, partylist_id, college_id)
SELECT uuid_generate_v4(),
    (SELECT id FROM elections WHERE name = 'University Student Council Elections 2025' LIMIT 1),
    (SELECT id FROM positions WHERE name = 'Secretary' AND election_id = (SELECT id FROM elections WHERE name='University Student Council Elections 2025' LIMIT 1) LIMIT 1),
    'David Lee', 
    'Maintaining accurate records and transparent governance.',
    'https://example.com/profiles/david.png',
    (SELECT id FROM partylists WHERE abbreviation = 'USF' LIMIT 1),
    (SELECT id FROM colleges WHERE acronym = 'CCIS' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM candidates WHERE name = 'David Lee'
);

-- Treasurer candidates
INSERT INTO candidates (id, election_id, position_id, name, platform, profile_picture, partylist_id, college_id)
SELECT uuid_generate_v4(),
    (SELECT id FROM elections WHERE name = 'University Student Council Elections 2025' LIMIT 1),
    (SELECT id FROM positions WHERE name = 'Treasurer' AND election_id = (SELECT id FROM elections WHERE name='University Student Council Elections 2025' LIMIT 1) LIMIT 1),
    'Emily Torres', 
    'Responsible financial management for student activities.',
    'https://example.com/profiles/emily.png',
    (SELECT id FROM partylists WHERE abbreviation = 'PSA' LIMIT 1),
    (SELECT id FROM colleges WHERE acronym = 'COB' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM candidates WHERE name = 'Emily Torres'
);

INSERT INTO candidates (id, election_id, position_id, name, platform, profile_picture, partylist_id, college_id)
SELECT uuid_generate_v4(),
    (SELECT id FROM elections WHERE name = 'University Student Council Elections 2025' LIMIT 1),
    (SELECT id FROM positions WHERE name = 'Treasurer' AND election_id = (SELECT id FROM elections WHERE name='University Student Council Elections 2025' LIMIT 1) LIMIT 1),
    'Alex Wong', 
    'Transparent budget allocation and financial reporting.',
    'https://example.com/profiles/alex.png',
    (SELECT id FROM partylists WHERE abbreviation = 'USF' LIMIT 1),
    (SELECT id FROM colleges WHERE acronym = 'COE' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM candidates WHERE name = 'Alex Wong'
);

-- Auditor candidates
INSERT INTO candidates (id, election_id, position_id, name, platform, profile_picture, partylist_id, college_id)
SELECT uuid_generate_v4(),
    (SELECT id FROM elections WHERE name = 'University Student Council Elections 2025' LIMIT 1),
    (SELECT id FROM positions WHERE name = 'Auditor' AND election_id = (SELECT id FROM elections WHERE name='University Student Council Elections 2025' LIMIT 1) LIMIT 1),
    'Nicole Santos', 
    'Ensuring accountability in all student council expenses.',
    'https://example.com/profiles/nicole.png',
    (SELECT id FROM partylists WHERE abbreviation = 'PSA' LIMIT 1),
    (SELECT id FROM colleges WHERE acronym = 'CCIS' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM candidates WHERE name = 'Nicole Santos'
);

INSERT INTO candidates (id, election_id, position_id, name, platform, profile_picture, partylist_id, college_id)
SELECT uuid_generate_v4(),
    (SELECT id FROM elections WHERE name = 'University Student Council Elections 2025' LIMIT 1),
    (SELECT id FROM positions WHERE name = 'Auditor' AND election_id = (SELECT id FROM elections WHERE name='University Student Council Elections 2025' LIMIT 1) LIMIT 1),
    'Kevin Park', 
    'Implementing systematic audit procedures for better governance.',
    'https://example.com/profiles/kevin.png',
    (SELECT id FROM partylists WHERE abbreviation = 'USF' LIMIT 1),
    (SELECT id FROM colleges WHERE acronym = 'COB' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM candidates WHERE name = 'Kevin Park'
);

-- Public Relations Officer candidates
INSERT INTO candidates (id, election_id, position_id, name, platform, profile_picture, partylist_id, college_id)
SELECT uuid_generate_v4(),
    (SELECT id FROM elections WHERE name = 'University Student Council Elections 2025' LIMIT 1),
    (SELECT id FROM positions WHERE name = 'Public Relations Officer' AND election_id = (SELECT id FROM elections WHERE name='University Student Council Elections 2025' LIMIT 1) LIMIT 1),
    'Sophia Miller', 
    'Amplifying student voices through effective communication channels.',
    'https://example.com/profiles/sophia.png',
    (SELECT id FROM partylists WHERE abbreviation = 'PSA' LIMIT 1),
    (SELECT id FROM colleges WHERE acronym = 'CAS' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM candidates WHERE name = 'Sophia Miller'
);

INSERT INTO candidates (id, election_id, position_id, name, platform, profile_picture, partylist_id, college_id)
SELECT uuid_generate_v4(),
    (SELECT id FROM elections WHERE name = 'University Student Council Elections 2025' LIMIT 1),
    (SELECT id FROM positions WHERE name = 'Public Relations Officer' AND election_id = (SELECT id FROM elections WHERE name='University Student Council Elections 2025' LIMIT 1) LIMIT 1),
    'Daniel Garcia', 
    'Building stronger relationships between students and the university.',
    'https://example.com/profiles/daniel.png',
    (SELECT id FROM partylists WHERE abbreviation = 'USF' LIMIT 1),
    (SELECT id FROM colleges WHERE acronym = 'COE' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM candidates WHERE name = 'Daniel Garcia'
);

-- Insert sample candidate experience only if they don't exist
INSERT INTO candidate_experience (id, candidate_id, organization, position, start_date, end_date)
SELECT uuid_generate_v4(),
    (SELECT id FROM candidates WHERE name = 'John Doe' LIMIT 1),
    'Tech Club', 'President', '2023-01-01', '2024-12-31'
WHERE NOT EXISTS (
  SELECT 1 FROM candidate_experience WHERE candidate_id = (SELECT id FROM candidates WHERE name = 'John Doe' LIMIT 1)
);

INSERT INTO candidate_experience (id, candidate_id, organization, position, start_date, end_date)
SELECT uuid_generate_v4(),
    (SELECT id FROM candidates WHERE name = 'Jane Smith' LIMIT 1),
    'Debate Society', 'Chairperson', '2022-01-01', NULL
WHERE NOT EXISTS (
  SELECT 1 FROM candidate_experience WHERE candidate_id = (SELECT id FROM candidates WHERE name = 'Jane Smith' LIMIT 1)
);

INSERT INTO candidate_experience (id, candidate_id, organization, position, start_date, end_date)
SELECT uuid_generate_v4(),
    (SELECT id FROM candidates WHERE name = 'Maria Rodriguez' LIMIT 1),
    'Arts Council', 'President', '2023-03-01', '2024-02-28'
WHERE NOT EXISTS (
  SELECT 1 FROM candidate_experience WHERE candidate_id = (SELECT id FROM candidates WHERE name = 'Maria Rodriguez' LIMIT 1)
);

INSERT INTO candidate_experience (id, candidate_id, organization, position, start_date, end_date)
SELECT uuid_generate_v4(),
    (SELECT id FROM candidates WHERE name = 'Michael Chen' LIMIT 1),
    'Business Club', 'Treasurer', '2022-06-01', '2023-05-31'
WHERE NOT EXISTS (
  SELECT 1 FROM candidate_experience WHERE candidate_id = (SELECT id FROM candidates WHERE name = 'Michael Chen' LIMIT 1)
);

INSERT INTO candidate_experience (id, candidate_id, organization, position, start_date, end_date)
SELECT uuid_generate_v4(),
    (SELECT id FROM candidates WHERE name = 'Sarah Johnson' LIMIT 1),
    'Literature Society', 'Secretary', '2022-09-01', '2024-08-31'
WHERE NOT EXISTS (
  SELECT 1 FROM candidate_experience WHERE candidate_id = (SELECT id FROM candidates WHERE name = 'Sarah Johnson' LIMIT 1)
);

INSERT INTO candidate_experience (id, candidate_id, organization, position, start_date, end_date)
SELECT uuid_generate_v4(),
    (SELECT id FROM candidates WHERE name = 'Emily Torres' LIMIT 1),
    'Finance Club', 'Vice President', '2023-05-01', NULL
WHERE NOT EXISTS (
  SELECT 1 FROM candidate_experience WHERE candidate_id = (SELECT id FROM candidates WHERE name = 'Emily Torres' LIMIT 1)
);

-- Insert sample students (voters) only if they don't exist
INSERT INTO students (student_id)
SELECT 'A12240987'
WHERE NOT EXISTS (
  SELECT 1 FROM students WHERE student_id = 'A12240987'
);

INSERT INTO students (student_id)
SELECT 'K23456789'
WHERE NOT EXISTS (
  SELECT 1 FROM students WHERE student_id = 'K23456789'
);

INSERT INTO students (student_id)
SELECT 'A34567890'
WHERE NOT EXISTS (
  SELECT 1 FROM students WHERE student_id = 'A34567890'
);

INSERT INTO students (student_id)
SELECT 'B12345678'
WHERE NOT EXISTS (
  SELECT 1 FROM students WHERE student_id = 'B12345678'
);

INSERT INTO students (student_id)
SELECT 'C87654321'
WHERE NOT EXISTS (
  SELECT 1 FROM students WHERE student_id = 'C87654321'
);

INSERT INTO students (student_id)
SELECT 'D98765432'
WHERE NOT EXISTS (
  SELECT 1 FROM students WHERE student_id = 'D98765432'
);

INSERT INTO students (student_id)
SELECT 'E45678901'
WHERE NOT EXISTS (
  SELECT 1 FROM students WHERE student_id = 'E45678901'
);

INSERT INTO students (student_id)
SELECT 'F10293847'
WHERE NOT EXISTS (
  SELECT 1 FROM students WHERE student_id = 'F10293847'
);

-- Insert sample votes only if they don't exist
INSERT INTO votes (id, election_id, student_id, candidate_id)
SELECT uuid_generate_v4(),
    (SELECT id FROM elections WHERE name = 'University Student Council Elections 2025' LIMIT 1),
    'A12240987',
    (SELECT id FROM candidates WHERE name = 'John Doe' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM votes WHERE student_id = 'A12240987' 
    AND candidate_id = (SELECT id FROM candidates WHERE name = 'John Doe' LIMIT 1)
);

INSERT INTO votes (id, election_id, student_id, candidate_id)
SELECT uuid_generate_v4(),
    (SELECT id FROM elections WHERE name = 'University Student Council Elections 2025' LIMIT 1),
    'K23456789',
    (SELECT id FROM candidates WHERE name = 'Jane Smith' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM votes WHERE student_id = 'K23456789' 
    AND candidate_id = (SELECT id FROM candidates WHERE name = 'Jane Smith' LIMIT 1)
);

INSERT INTO votes (id, election_id, student_id, candidate_id)
SELECT uuid_generate_v4(),
    (SELECT id FROM elections WHERE name = 'University Student Council Elections 2025' LIMIT 1),
    'A34567890',
    (SELECT id FROM candidates WHERE name = 'Maria Rodriguez' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM votes WHERE student_id = 'A34567890' 
    AND candidate_id = (SELECT id FROM candidates WHERE name = 'Maria Rodriguez' LIMIT 1)
);

INSERT INTO votes (id, election_id, student_id, candidate_id)
SELECT uuid_generate_v4(),
    (SELECT id FROM elections WHERE name = 'University Student Council Elections 2025' LIMIT 1),
    'B12345678',
    (SELECT id FROM candidates WHERE name = 'David Lee' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM votes WHERE student_id = 'B12345678' 
    AND candidate_id = (SELECT id FROM candidates WHERE name = 'David Lee' LIMIT 1)
);

INSERT INTO votes (id, election_id, student_id, candidate_id)
SELECT uuid_generate_v4(),
    (SELECT id FROM elections WHERE name = 'University Student Council Elections 2025' LIMIT 1),
    'C87654321',
    (SELECT id FROM candidates WHERE name = 'Alex Wong' LIMIT 1)
WHERE NOT EXISTS (
  SELECT 1 FROM votes WHERE student_id = 'C87654321' 
    AND candidate_id = (SELECT id FROM candidates WHERE name = 'Alex Wong' LIMIT 1)
);