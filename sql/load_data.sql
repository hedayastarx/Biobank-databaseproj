INSERT INTO Donors (first_name, last_name, date_of_birth, gender, email, phone, medical_history) VALUES
('John', 'Smith', '1985-03-15', 'Male', 'john.smith@email.com', '555-0101', 'No significant history'),
('Maria', 'Garcia', '1990-07-22', 'Female', 'maria.garcia@email.com', '555-0102', 'Type 2 Diabetes'),
('Robert', 'Johnson', '1978-11-02', 'Male', 'robert.j@email.com', '555-0103', 'Hypertension'),
('Sarah', 'Williams', '1995-01-10', 'Female', 'sarah.w@email.com', '555-0104', 'None'),
('Michael', 'Brown', '1982-05-18', 'Male', 'michael.b@email.com', '555-0105', 'Asthma'),
('Emily', 'Davis', '2000-08-30', 'Female', 'emily.d@email.com', '555-0106', 'Allergies'),
('James', 'Miller', '1965-12-05', 'Male', 'james.m@email.com', '555-0107', 'Heart Disease'),
('Patricia', 'Wilson', '1992-04-25', 'Female', 'patricia.w@email.com', '555-0108', 'None'),
('Charles', 'Martinez', '1988-09-14', 'Male', 'charles.m@email.com', '555-0109', 'High Cholesterol'),
('Lisa', 'Taylor', '1975-06-20', 'Female', 'lisa.t@email.com', '555-0110', 'Thyroid Condition');

INSERT INTO Sample_Types (type_name, description, storage_requirements, shelf_life_days) VALUES
('Whole Blood', 'Whole blood sample with anticoagulant', '4°C', 30),
('Plasma', 'Plasma separated from whole blood', '-20°C', 365),
('Serum', 'Serum separated from whole blood', '-20°C', 365),
('DNA Extract', 'Purified genomic DNA', '-80°C', 3650),
('Tissue Biopsy', 'Tissue sample from biopsy', 'LN2', 3650);

INSERT INTO Storage_Locations (location_name, freezer_type, shelf_number, box_number, capacity, current_usage) VALUES
('Freezer A-1', '-80°C', 1, 1, 100, 12),
('Freezer A-2', '-80°C', 1, 2, 100, 😎,
('Freezer B-1', '-20°C', 2, 1, 50, 6),
('Freezer B-2', '-20°C', 2, 2, 50, 4),
('LN2 Tank C-1', 'LN2', 3, 1, 25, 3);

INSERT INTO Samples (donor_id, type_id, collection_date, quantity, unit, sample_status) VALUES
(1, 1, '2025-01-15', 10, 'ml', 'Available'),
(1, 2, '2025-01-15', 5, 'ml', 'Used'),
(2, 1, '2025-02-01', 8, 'ml', 'Available'),
(2, 3, '2025-02-01', 4, 'ml', 'Available'),
(3, 4, '2025-02-10', 200, 'μl', 'Available'),
(3, 1, '2025-02-10', 10, 'ml', 'Used'),
(4, 2, '2025-03-05', 5, 'ml', 'Available'),
(5, 5, '2025-03-15', 50, 'mg', 'Available'),
(6, 4, '2025-03-20', 150, 'μl', 'Available'),
(7, 1, '2025-04-01', 10, 'ml', 'Discarded');

INSERT INTO Sample_Storage (sample_id, location_id, stored_by) VALUES
(1, 1, 'Dr. Anderson'),
(2, 3, 'Dr. Anderson'),
(3, 1, 'Dr. Kim'),
(4, 2, 'Dr. Kim'),
(5, 1, 'Dr. Patel'),
(6, 4, 'Dr. Patel'),
(7, 2, 'Dr. Lee'),
(8, 5, 'Dr. Lee'),
(9, 2, 'Dr. Garcia'),
(10, 5, 'Dr. Garcia');

INSERT INTO Researchers (first_name, last_name, email, department, institution) VALUES
('James', 'Anderson', 'j.anderson@biotech.edu', 'Oncology', 'National Cancer Center'),
('Sarah', 'Kim', 's.kim@biotech.edu', 'Genomics', 'Genomics Institute'),
('Robert', 'Patel', 'r.patel@biotech.edu', 'Immunology', 'Vaccine Research Lab'),
('Laura', 'Lee', 'l.lee@biotech.edu', 'Neurology', 'Brain Research Center'),
('Carlos', 'Garcia', 'c.garcia@biotech.edu', 'Molecular Biology', 'Molecular Medicine Lab');

INSERT INTO Test_Requests (sample_id, researcher_id, test_type, priority, status) VALUES
(1, 1, 'CBC Analysis', 'High', 'Completed'),
(1, 2, 'DNA Sequencing', 'Medium', 'In Progress'),
(3, 3, 'Glucose Test', 'High', 'Completed'),
(4, 4, 'Cholesterol Panel', 'Medium', 'Pending'),
(5, 1, 'Genetic Screening', 'Urgent', 'In Progress'),
(7, 2, 'Lipid Profile', 'Low', 'Pending'),
(8, 3, 'Immunoassay', 'High', 'Completed'),
(9, 4, 'PCR Analysis', 'Medium', 'Completed'),
(9, 5, 'Gene Expression', 'Medium', 'In Progress'),
(10, 1, 'Quality Control', 'Low', 'Cancelled');

INSERT INTO Test_Results (request_id, result_value, result_unit, is_abnormal, interpretation, performed_by) VALUES
(1, '5.2', 'x10^6/μL', FALSE, 'Normal CBC results', 'Lab Technician A'),
(1, '96.5', 'ng/μL', FALSE, 'Good quality DNA', 'Lab Technician B'),
(3, '110', 'mg/dL', TRUE, 'Elevated glucose levels', 'Lab Technician A'),
(5, 'Negative', NULL, FALSE, 'No genetic variants found', 'Lab Technician C'),
(7, '25', 'IU/mL', TRUE, 'Elevated antibody levels', 'Lab Technician B'),
(8, 'Positive', NULL, FALSE, 'Target gene detected', 'Lab Technician A'),
(9, '1.8', 'fold change', TRUE, 'Upregulated expression', 'Lab Technician C'),
(8, 'Negative', NULL, FALSE, 'No contamination detected', 'Lab Technician B'),
(5, '2.3', 'ratio', FALSE, 'Normal ratio', 'Lab Technician A'),
(4, '195', 'mg/dL', TRUE, 'High cholesterol', 'Lab Technician C');
