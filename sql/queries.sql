-- Query 1: Available samples with donor info
SELECT s.sample_id, d.first_name, d.last_name, st.type_name, 
       s.quantity, s.unit, s.collection_date
FROM Samples s
JOIN Donors d ON s.donor_id = d.donor_id
JOIN Sample_Types st ON s.type_id = st.type_id
WHERE s.sample_status = 'Available';

-- Query 2: Samples with storage locations
SELECT s.sample_id, st.type_name, sl.location_name, 
       ss.storage_date, ss.stored_by
FROM Samples s
JOIN Sample_Types st ON s.type_id = st.type_id
JOIN Sample_Storage ss ON s.sample_id = ss.sample_id
JOIN Storage_Locations sl ON ss.location_id = sl.location_id;

-- Query 3: Count samples by type
SELECT st.type_name, COUNT(s.sample_id) AS sample_count,
       AVG(s.quantity) AS avg_quantity
FROM Sample_Types st
LEFT JOIN Samples s ON st.type_id = s.type_id
GROUP BY st.type_id;

-- Query 4: Researchers with multiple requests
SELECT r.first_name, r.last_name, COUNT(tr.request_id) AS request_count
FROM Researchers r
JOIN Test_Requests tr ON r.researcher_id = tr.researcher_id
GROUP BY r.researcher_id
HAVING COUNT(tr.request_id) > 1;

-- Query 5: Abnormal test results
SELECT s.sample_id, d.first_name, d.last_name, 
       tr.test_type, tre.result_value, tre.interpretation
FROM Samples s
JOIN Donors d ON s.donor_id = d.donor_id
JOIN Test_Requests tr ON s.sample_id = tr.sample_id
JOIN Test_Results tre ON tr.request_id = tre.request_id
WHERE tre.is_abnormal = TRUE;

-- Query 6: Update sample status
UPDATE Samples 
SET sample_status = 'Used' 
WHERE sample_id IN (
    SELECT DISTINCT sample_id 
    FROM Test_Requests 
    WHERE status = 'Completed'
);

-- Query 7: Insert new test request
INSERT INTO Test_Requests (sample_id, researcher_id, test_type, priority) 
VALUES (1, 1, 'COVID-19 Antibody Test', 'High');

-- Query 8: Delete cancelled requests
DELETE FROM Test_Requests 
WHERE status = 'Cancelled' AND request_date < DATE_SUB(CURDATE(), INTERVAL 30 DAY);
