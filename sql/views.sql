CREATE VIEW Sample_Tracking_View AS
SELECT 
    s.sample_id,
    CONCAT(d.first_name, ' ', d.last_name) AS donor_name,
    d.phone AS donor_phone,
    st.type_name AS sample_type,
    s.quantity,
    s.unit,
    s.collection_date,
    s.sample_status,
    sl.location_name AS storage_location,
    sl.freezer_type,
    ss.storage_date AS stored_on,
    ss.stored_by
FROM Samples s
JOIN Donors d ON s.donor_id = d.donor_id
JOIN Sample_Types st ON s.type_id = st.type_id
LEFT JOIN Sample_Storage ss ON s.sample_id = ss.sample_id
LEFT JOIN Storage_Locations sl ON ss.location_id = sl.location_id;

CREATE VIEW Research_Request_Summary AS
SELECT 
    tr.request_id,
    CONCAT(r.first_name, ' ', r.last_name) AS researcher_name,
    r.department,
    tr.test_type,
    tr.request_date,
    tr.status,
    CONCAT(d.first_name, ' ', d.last_name) AS donor_name,
    tre.result_value,
    tre.interpretation,
    tre.is_abnormal
FROM Test_Requests tr
JOIN Researchers r ON tr.researcher_id = r.researcher_id
JOIN Samples s ON tr.sample_id = s.sample_id
JOIN Donors d ON s.donor_id = d.donor_id
LEFT JOIN Test_Results tre ON tr.request_id = tre.request_id;
