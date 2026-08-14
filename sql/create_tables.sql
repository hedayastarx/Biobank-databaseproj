-- 1. DONORS TABLE
CREATE TABLE Donors (
    donor_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE NOT NULL,
    gender ENUM('Male', 'Female', 'Other') NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20),
    address TEXT,
    medical_history TEXT,
    registration_date DATE DEFAULT CURRENT_DATE
);

-- 2. CONSENT TABLE
CREATE TABLE Consent (
    consent_id INT PRIMARY KEY AUTO_INCREMENT,
    donor_id INT NOT NULL,
    consent_date DATE NOT NULL,
    consent_type ENUM('Biobank', 'Research', 'Clinical') NOT NULL,
    consent_version VARCHAR(10),
    status ENUM('Active', 'Withdrawn', 'Expired') DEFAULT 'Active',
    expiry_date DATE,
    FOREIGN KEY (donor_id) REFERENCES Donors(donor_id) ON DELETE CASCADE
);

-- 3. SAMPLE_TYPES TABLE
CREATE TABLE Sample_Types (
    type_id INT PRIMARY KEY AUTO_INCREMENT,
    type_name VARCHAR(50) NOT NULL UNIQUE,
    description TEXT,
    storage_requirements VARCHAR(100),
    shelf_life_days INT
);

-- 4. STORAGE_LOCATIONS TABLE
CREATE TABLE Storage_Locations (
    location_id INT PRIMARY KEY AUTO_INCREMENT,
    location_name VARCHAR(100) NOT NULL,
    freezer_type ENUM('-80°C', '-20°C', '4°C', 'LN2') NOT NULL,
    shelf_number INT,
    box_number INT,
    capacity INT,
    current_usage INT DEFAULT 0
);

-- 5. SAMPLES TABLE
CREATE TABLE Samples (
    sample_id INT PRIMARY KEY AUTO_INCREMENT,
    donor_id INT NOT NULL,
    type_id INT NOT NULL,
    collection_date DATE NOT NULL,
    quantity DECIMAL(10,2) NOT NULL,
    unit ENUM('ml', 'mg', 'μl', 'cells') NOT NULL,
    sample_status ENUM('Available', 'Used', 'Degraded', 'Discarded') DEFAULT 'Available',
    notes TEXT,
    FOREIGN KEY (donor_id) REFERENCES Donors(donor_id) ON DELETE CASCADE,
    FOREIGN KEY (type_id) REFERENCES Sample_Types(type_id)
);

-- 6. SAMPLE_STORAGE
CREATE TABLE Sample_Storage (
    storage_id INT PRIMARY KEY AUTO_INCREMENT,
    sample_id INT NOT NULL,
    location_id INT NOT NULL,
    storage_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    stored_by VARCHAR(100),
    removal_date DATETIME,
    FOREIGN KEY (sample_id) REFERENCES Samples(sample_id) ON DELETE CASCADE,
    FOREIGN KEY (location_id) REFERENCES Storage_Locations(location_id),
    UNIQUE KEY unique_sample_location (sample_id, location_id)
);

-- 7. RESEARCHERS TABLE
CREATE TABLE Researchers (
    researcher_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    department VARCHAR(100),
    institution VARCHAR(100),
    phone VARCHAR(20),
    certification_date DATE
);

-- 8. TEST_REQUESTS TABLE
CREATE TABLE Test_Requests (
    request_id INT PRIMARY KEY AUTO_INCREMENT,
    sample_id INT NOT NULL,
    researcher_id INT NOT NULL,
    test_type VARCHAR(100) NOT NULL,
    request_date DATE DEFAULT CURRENT_DATE,
    priority ENUM('Low', 'Medium', 'High', 'Urgent') DEFAULT 'Medium',
    status ENUM('Pending', 'In Progress', 'Completed', 'Cancelled') DEFAULT 'Pending',
    completion_date DATE,
    FOREIGN KEY (sample_id) REFERENCES Samples(sample_id) ON DELETE CASCADE,
    FOREIGN KEY (researcher_id) REFERENCES Researchers(researcher_id)
);

-- 9. TEST_RESULTS TABLE
CREATE TABLE Test_Results (
    result_id INT PRIMARY KEY AUTO_INCREMENT,
    request_id INT NOT NULL,
    result_date DATE DEFAULT CURRENT_DATE,
    result_value VARCHAR(200),
    result_unit VARCHAR(50),
    is_abnormal BOOLEAN DEFAULT FALSE,
    interpretation TEXT,
    performed_by VARCHAR(100),
    FOREIGN KEY (request_id) REFERENCES Test_Requests(request_id) ON DELETE CASCADE
);
