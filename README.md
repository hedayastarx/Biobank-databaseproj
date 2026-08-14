# Biobank and Biospecimen Management System

## Database System: MySQL

## Project Description
A comprehensive database system to manage biological samples, donors, storage locations, and research requests in a biobank facility.

## Tables (9 total):
- Donors - Donor demographic and medical information
- Consent - Donor consent forms and status
- Sample_Types - Sample categories
- Storage_Locations - Freezer and storage unit details
- Samples - Core entity linking donors to sample types
- Sample_Storage - Links samples to storage locations (M:M relationship)
- Researchers - Academic and research personnel
- Test_Requests - Requests for sample testing
- Test_Results - Results from completed tests

## How to Run:
1. Open MySQL
2. Run sql/create_tables.sql - Creates all tables
3. Run sql/load_data.sql - Loads test data
4. Run sql/views.sql - Creates database views
5. Run sql/triggers_procedures.sql - Creates triggers and procedures
6. Test with sql/queries.sql - Run sample queries

## Features:
- Normalized to 3NF
- 2 Views for reporting
- 2 Triggers for automation
- 2 Procedures + 1 Function
- Sample data included
