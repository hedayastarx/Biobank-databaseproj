DELIMITER //
CREATE TRIGGER update_storage_capacity
AFTER INSERT ON Sample_Storage
FOR EACH ROW
BEGIN
    UPDATE Storage_Locations 
    SET current_usage = current_usage + 1 
    WHERE location_id = NEW.location_id;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER update_sample_status_on_test_completion
AFTER UPDATE ON Test_Requests
FOR EACH ROW
BEGIN
    IF NEW.status = 'Completed' AND OLD.status != 'Completed' THEN
        UPDATE Samples 
        SET sample_status = 'Used' 
        WHERE sample_id = NEW.sample_id;
    END IF;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE GetSampleAvailabilityReport(
    IN donor_id_param INT
)
BEGIN
    SELECT 
        s.sample_id,
        st.type_name,
        s.quantity,
        s.unit,
        s.collection_date,
        s.sample_status,
        COUNT(tr.request_id) AS total_requests
    FROM Samples s
    JOIN Sample_Types st ON s.type_id = st.type_id
    LEFT JOIN Test_Requests tr ON s.sample_id = tr.sample_id
    WHERE s.donor_id = donor_id_param
    GROUP BY s.sample_id;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE ArchiveOldTestRequests(IN days_old INT)
BEGIN
    UPDATE Test_Requests 
    SET status = 'Archived' 
    WHERE status = 'Completed' 
    AND completion_date < DATE_SUB(CURDATE(), INTERVAL days_old DAY);
END //
DELIMITER ;

DELIMITER //
CREATE FUNCTION GetDonorAge(donor_id_param INT) 
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE age INT;
    SELECT TIMESTAMPDIFF(YEAR, date_of_birth, CURDATE()) INTO age
    FROM Donors
    WHERE donor_id = donor_id_param;
    RETURN age;
END //
DELIMITER ;
