DROP DATABASE IF EXISTS conference_portal;
CREATE DATABASE conference_portal;
USE conference_portal;

-- Conferences table
CREATE TABLE IF NOT EXISTS conferences (
  conference_id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  total_days INT NOT NULL,
  description TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Halls table
CREATE TABLE IF NOT EXISTS halls (
  hall_id INT PRIMARY KEY AUTO_INCREMENT,
  conference_id INT NOT NULL,
  hall_name VARCHAR(100) NOT NULL,
  capacity INT NOT NULL,
  location VARCHAR(200),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (conference_id) REFERENCES conferences(conference_id) ON DELETE CASCADE
);

-- Speakers table
CREATE TABLE IF NOT EXISTS speakers (
  speaker_id INT PRIMARY KEY AUTO_INCREMENT,
  speaker_code VARCHAR(10) UNIQUE NOT NULL,
  full_name VARCHAR(200) NOT NULL,
  email VARCHAR(150) UNIQUE NOT NULL,
  phone VARCHAR(20),
  title VARCHAR(300),
  bio TEXT,
  profile_image VARCHAR(255),
  password_hash VARCHAR(255) DEFAULT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Time slots table
CREATE TABLE IF NOT EXISTS time_slots (
  slot_id INT PRIMARY KEY AUTO_INCREMENT,
  conference_id INT NOT NULL,
  day_number INT NOT NULL,
  start_time TIME NOT NULL,
  end_time TIME NOT NULL,
  slot_name VARCHAR(150),
  slot_order INT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (conference_id) REFERENCES conferences(conference_id)
);

-- Schedule table
CREATE TABLE IF NOT EXISTS schedules (
  schedule_id INT PRIMARY KEY AUTO_INCREMENT,
  conference_id INT NOT NULL,
  speaker_id INT NOT NULL,
  hall_id INT NOT NULL,
  slot_id INT NOT NULL,
  session_title VARCHAR(300),
  session_description TEXT,
  status ENUM('confirmed', 'pending', 'cancelled') DEFAULT 'confirmed',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (conference_id) REFERENCES conferences(conference_id) ON DELETE CASCADE,
  FOREIGN KEY (speaker_id) REFERENCES speakers(speaker_id) ON DELETE CASCADE,
  FOREIGN KEY (hall_id) REFERENCES halls(hall_id) ON DELETE CASCADE,
  FOREIGN KEY (slot_id) REFERENCES time_slots(slot_id) ON DELETE CASCADE,
  UNIQUE KEY unique_schedule (hall_id, slot_id)
);

CREATE TABLE uploaded_files (
    file_id INT PRIMARY KEY AUTO_INCREMENT,
    schedule_id INT NOT NULL,
    hall_id INT NOT NULL,              -- NEW: Direct hall reference
    day_number INT NOT NULL,           -- NEW: Direct day reference  
    speaker_code VARCHAR(10) NOT NULL, -- NEW: Direct speaker code
    slot_order_in_day INT NOT NULL,    -- NEW: For filename ordering (slot_order % total_days)
    original_name VARCHAR(255) NOT NULL,
    original_path VARCHAR(500) NOT NULL,
    stored_filename VARCHAR(255) NOT NULL, -- Will be: 1_SP001_originalname.pptx
    stored_path VARCHAR(500) NOT NULL,
    file_size INT,
    file_type VARCHAR(100),
    upload_status ENUM('pending', 'processed', 'failed') DEFAULT 'pending',
    upload_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (schedule_id) REFERENCES schedules(schedule_id) ON DELETE CASCADE,
    FOREIGN KEY (hall_id) REFERENCES halls(hall_id) ON DELETE CASCADE
);

-- Insert conferences
INSERT INTO conferences (conference_id, name, start_date, end_date, total_days, description) VALUES
(1, 'Summit Hub 2025', '2025-09-14 18:30:00', '2025-09-17 18:30:00', 4, 'Annual technology conference focusing on AI, Cloud, and Digital Transformation');

-- Insert halls
INSERT INTO halls (hall_id, conference_id, hall_name, capacity, location) VALUES
(1, 1, 'Hall A', 500, 'Ground Floor - East Wing'),
(2, 1, 'Hall B', 300, 'Ground Floor - West Wing'),
(3, 1, 'Hall C', 200, 'First Floor - North'),
(4, 1, 'Hall D', 150, 'First Floor - South');

-- Insert speakers
INSERT INTO speakers (speaker_id, speaker_code, full_name, email, phone, title, bio, profile_image) VALUES
(1, 'SP001', 'Sarvan D Suvarna', 'sarvan.suvarna@email.com', '8618827584', 'AI-DS Engineer', 'Passionate about AI and data-driven solutions.', NULL),
(2, 'SP002', 'Paresh R Nayak', 'paresh.nayak@email.com', '7892276218', 'IoT Architect', 'Works on connected devices and smart ecosystems.', NULL),
(3, 'SP003', 'Adithya B Hanglur', 'adithya.hanglur@email.com', '7892619743', 'Cloud Engineer', 'Working on scalable cloud-based applications.', NULL),
(4, 'SP004', 'Varun Bhat', 'varun.bhat@email.com', '7348929738', 'Full Stack Developer', 'Works with modern web and mobile frameworks.', NULL),
(5, 'SP005', 'Puneeth', 'puneeth@email.com', '9242497946', 'Cloud Security Analyst', 'Focused on cloud-native security.', NULL),
(6, 'SP006', 'Kaushik Poojary', 'kaushik.poojary@email.com', '9019367791', 'Robotics Engineer', 'Designing and testing autonomous systems.', NULL),
(7, 'SP007', 'Prajwal Y', 'prajwal.y@email.com', '8497100162', 'AI Researcher', 'Interested in computer vision and NLP.', NULL),
(8, 'SP008', 'Vishwas', 'vishwas@email.com', '8050021739', 'Game Designer', 'Building interactive experiences for players.', NULL),
(9, 'SP009', 'K Vivek Kamath', 'vivek.kamath@email.com', '8105699135', 'Blockchain Developer', 'Exploring decentralized finance and smart contracts.', NULL),
(10, 'SP010', 'Kevin Mendonca', 'kevin.mendonca@email.com', '8147282379', 'Game Developer', 'Building immersive gaming experiences.', NULL),
(11, 'SP011', 'Shobith S', 'shobith.s@email.com', '8618987158', 'Data Scientist', 'Works on big data and applied machine learning.', NULL),
(12, 'SP012', 'Vivan Sanjay Nayak', 'vivan.nayak@email.com', '7411135027', 'Tech Entrepreneur', 'Exploring startups in AI and SaaS.', NULL),
(13, 'SP013', 'Athul Nayak', 'athul.nayak@email.com', '7411935492', 'Data Engineer', 'Building robust data pipelines for analytics.', NULL),
(14, 'SP014', 'Pramith Nayak', 'pramith.nayak@email.com', '9663193782', 'Web Developer', 'Expert in MERN stack applications.', NULL),
(15, 'SP015', 'Akshay Kumar', 'akshay.kumar@email.com', '9972147956', 'Software Developer', 'Specializes in backend development and APIs.', NULL),
(16, 'SP016', 'Prathvi V Suvarna', 'prathvi.suvarna@email.com', '8792049478', 'AR/VR Specialist', 'Works on immersive AR experiences.', NULL),
(17, 'SP017', 'Kotian Shubham', 'shubham.kotian@email.com', '7338332785', 'DevOps Engineer', 'Specializes in CI/CD automation.', NULL),
(18, 'SP018', 'Ayush M Anchan', 'ayush.anchan@email.com', '9743175964', 'Machine Learning Engineer', 'Works on predictive analytics and ML pipelines.', NULL),
(19, 'SP019', 'Thilak', 'thilak@email.com', '9108407436', 'System Architect', 'Designs enterprise-level software systems.', NULL),
(20, 'SP020', 'Manvith M Poojary', 'manvith.poojary@email.com', '9482409183', 'Mobile App Developer', 'Creating scalable mobile applications.', NULL);

-- Insert time slots
INSERT INTO time_slots (slot_id, conference_id, day_number, start_time, end_time, slot_name, slot_order) VALUES
(1, 1, 1, '10:00:00', '11:00:00', 'Opening Keynote', 1),
(2, 1, 1, '11:30:00', '12:30:00', 'Morning Technical Session', 2),
(3, 1, 1, '14:00:00', '15:00:00', 'Afternoon Workshop', 3),
(4, 1, 1, '15:30:00', '16:30:00', 'Panel Discussion', 4),
(5, 1, 2, '10:00:00', '11:00:00', 'Day 2 Keynote', 5),
(6, 1, 2, '11:30:00', '12:30:00', 'Deep Dive Session 1', 6),
(7, 1, 2, '14:00:00', '15:00:00', 'Deep Dive Session 2', 7),
(8, 1, 2, '15:30:00', '16:30:00', 'Industry Roundtable', 8),
(9, 1, 3, '10:00:00', '11:00:00', 'Innovation Showcase', 9),
(10, 1, 3, '11:30:00', '12:30:00', 'Startup Presentations', 10),
(11, 1, 3, '14:00:00', '15:00:00', 'Technology Trends', 11),
(12, 1, 3, '15:30:00', '16:30:00', 'Networking Session', 12),
(13, 1, 4, '10:00:00', '11:00:00', 'Future Technologies', 13),
(14, 1, 4, '11:30:00', '12:30:00', 'Best Practices', 14),
(15, 1, 4, '14:00:00', '15:00:00', 'Implementation Workshop', 15),
(16, 1, 4, '15:30:00', '17:00:00', 'Closing Ceremony', 16);

-- Insert schedules
INSERT INTO schedules (schedule_id, conference_id, speaker_id, hall_id, slot_id, session_title, session_description, status) VALUES
(1, 1, 1, 1, 1, 'AI-Driven Solutions for the Future', NULL, 'confirmed'),
(3, 1, 3, 3, 1, 'Scalable Cloud Applications', NULL, 'confirmed'),
(4, 1, 4, 4, 1, 'Modern Web & Mobile Development', NULL, 'confirmed'),
(5, 1, 5, 1, 2, 'Securing the Cloud-Native World', NULL, 'confirmed'),
(6, 1, 6, 2, 2, 'Autonomous Robotics in Action', NULL, 'confirmed'),
(7, 1, 7, 3, 2, 'Advances in Computer Vision & NLP', NULL, 'confirmed'),
(8, 1, 8, 4, 2, 'Designing Engaging Game Experiences', NULL, 'confirmed'),
(9, 1, 9, 1, 5, 'Smart Contracts & DeFi Development', NULL, 'confirmed'),
(10, 1, 10, 2, 5, 'Immersive Game Development Techniques', NULL, 'confirmed'),
(11, 1, 11, 3, 5, 'Applied Machine Learning at Scale', NULL, 'confirmed'),
(12, 1, 12, 4, 5, 'From AI to SaaS: The Startup Journey', NULL, 'confirmed'),
(13, 1, 13, 1, 6, 'Data Pipelines for Analytics', NULL, 'confirmed'),
(14, 1, 14, 2, 6, 'Next-Gen MERN Stack Applications', NULL, 'confirmed'),
(15, 1, 15, 3, 6, 'Optimizing Backend Systems & APIs', NULL, 'confirmed'),
(16, 1, 16, 4, 6, 'Building Immersive AR Experiences', NULL, 'confirmed'),
(17, 1, 17, 1, 9, 'CI/CD and DevOps Automation', NULL, 'confirmed'),
(18, 1, 18, 2, 9, 'Predictive Analytics with ML Pipelines', NULL, 'confirmed'),
(19, 1, 19, 3, 9, 'Enterprise Software Architecture', NULL, 'confirmed'),
(20, 1, 20, 4, 9, 'Scaling Mobile Applications', NULL, 'confirmed');
