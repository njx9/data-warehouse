-- have to insert before update for provider data

IF OBJECT_ID ( 'update_FromStaging', 'P' ) IS NOT NULL   
    DROP PROCEDURE update_FromStaging;  
GO  
CREATE PROCEDURE update_FromStaging  
AS  
    SET NOCOUNT ON; 
    -- update provider data from dm_elig_staging
    -- name
    UPDATE  p
    SET     p.provider_name=
                REPLACE(case 
                        when charindex('.MD.',s.provider_name) > 0 
                            then left(s.provider_name, charindex('.MD.',s.provider_name)-1) 
                        when charindex('.NP.',s.provider_name) > 0
                            then left(s.provider_name, charindex('.NP.',s.provider_name)-1) 
                        when charindex('.DO.',s.provider_name) > 0
                            then left(s.provider_name, charindex('.DO.',s.provider_name)-1)
                        when charindex('.FNP.',s.provider_name) > 0
                            then left(s.provider_name, charindex('.FNP.',s.provider_name)-1)
                        when charindex('.PAC.',s.provider_name) > 0
                            then left(s.provider_name, charindex('.PAC.',s.provider_name)-1)
                        when charindex('.HER.',s.provider_name) > 0
                            then left(s.provider_name, charindex('.HER.',s.provider_name)-1)
                        else s.provider_name
                    end
                    , '.', ' ')
            , p.update_date=getdate()
    FROM    dm_providers p
    JOIN    dm_elig_staging s
        ON  s.provider_npi=p.provider_npi
        AND REPLACE(case 
                    when charindex('.MD.',s.provider_name) > 0 
                        then left(s.provider_name, charindex('.MD.',s.provider_name)-1) 
                    when charindex('.NP.',s.provider_name) > 0
                        then left(s.provider_name, charindex('.NP.',s.provider_name)-1) 
                    when charindex('.DO.',s.provider_name) > 0
                        then left(s.provider_name, charindex('.DO.',s.provider_name)-1)
                    when charindex('.FNP.',s.provider_name) > 0
                        then left(s.provider_name, charindex('.FNP.',s.provider_name)-1)
                    when charindex('.PAC.',s.provider_name) > 0
                        then left(s.provider_name, charindex('.PAC.',s.provider_name)-1)
                    when charindex('.HER.',s.provider_name) > 0
                        then left(s.provider_name, charindex('.HER.',s.provider_name)-1)
                    else s.provider_name
                end
                , '.', ' ')<>ISNULL(p.provider_name,' ')
    -- provider_contract
    UPDATE  p
    SET     p.provider_contract=s.provider_contract, p.update_date=getdate()
    FROM    dm_providers p
    JOIN    dm_elig_staging s
        ON  s.provider_npi=p.provider_npi
        AND s.provider_contract<>ISNULL(p.provider_contract,' ')
    -- provider exists?
    UPDATE	p
    SET		p.active=1, p.update_date=getdate()
    FROM	dm_providers p
    JOIN	dm_elig_staging s
        ON	s.provider_npi=p.provider_npi
        AND	p.active<>1
    -- update provider data from dm_roster_staging
    -- type
    UPDATE  p
    SET     p.type=s.type, p.update_date=getdate()
    FROM    dm_providers p
    JOIN    dm_roster_staging s
        ON  s.provider_npi=p.provider_npi
        AND s.type<>ISNULL(p.type,' ')
    -- specialty
    UPDATE  p
    SET     p.specialty=s.specialty, p.update_date=getdate()
    FROM    dm_providers p
    JOIN    dm_roster_staging s
        ON  s.provider_npi=p.provider_npi
        AND s.specialty<>ISNULL(p.specialty,' ')
    -- practice_name
    UPDATE  p
    SET     p.practice_name=s.practice_name, p.update_date=getdate()
    FROM    dm_providers p
    JOIN    dm_roster_staging s
        ON  s.provider_npi=p.provider_npi
        AND s.practice_name<>ISNULL(p.practice_name,' ')
    -- practice_npi
    UPDATE  p
    SET     p.practice_npi=s.practice_npi, p.update_date=getdate()
    FROM    dm_providers p
    JOIN    dm_roster_staging s
        ON  s.provider_npi=p.provider_npi
        AND s.practice_npi<>ISNULL(p.practice_npi,' ')
    -- region
    UPDATE  p
    SET     p.region=s.region, p.update_date=getdate()
    FROM    dm_providers p
    JOIN    dm_roster_staging s
        ON  s.provider_npi=ISNULL(p.provider_npi,' ')
        AND s.region<>p.region
    -- contract_entity
    UPDATE  p
    SET     p.contract_entity=s.contract_entity, p.update_date=getdate()
    FROM    dm_providers p
    JOIN    dm_roster_staging s
        ON  s.provider_npi=p.provider_npi
        AND s.contract_entity<>ISNULL(p.contract_entity,' ')
    -- practice_tin
    UPDATE  p
    SET     p.practice_tin=s.practice_tin, p.update_date=getdate()
    FROM    dm_providers p
    JOIN    dm_roster_staging s
        ON  s.provider_npi=p.provider_npi
        AND s.practice_tin<>ISNULL(p.practice_tin,' ')
    -- network
    UPDATE  p
    SET     p.network=s.network, p.update_date=getdate()
    FROM    dm_providers p
    JOIN    dm_roster_staging s
        ON  s.provider_npi=p.provider_npi
        AND s.network<>ISNULL(p.network,' ')
    -- practice_address
    UPDATE  p
    SET     p.practice_address=s.practice_address, p.update_date=getdate()
    FROM    dm_providers p
    JOIN    dm_roster_staging s
        ON  s.provider_npi=p.provider_npi
        AND s.practice_address<>ISNULL(p.practice_address,' ')
    -- practice_city
    UPDATE  p
    SET     p.practice_city=s.practice_city, p.update_date=getdate()
    FROM    dm_providers p
    JOIN    dm_roster_staging s
        ON  s.provider_npi=p.provider_npi
        AND s.practice_city<>ISNULL(p.practice_city,' ')
    -- practice_state
    UPDATE  p
    SET     p.practice_state=s.practice_state, p.update_date=getdate()
    FROM    dm_providers p
    JOIN    dm_roster_staging s
        ON  s.provider_npi=p.provider_npi
        AND s.practice_state<>ISNULL(p.practice_state,' ')
    -- practice_zip
    UPDATE  p
    SET     p.practice_zip=s.practice_zip, p.update_date=getdate()
    FROM    dm_providers p
    JOIN    dm_roster_staging s
        ON  s.provider_npi=p.provider_npi
        AND s.practice_zip<>ISNULL(p.practice_zip,' ')
    -- practice_county
    UPDATE  p
    SET     p.practice_county=s.practice_county, p.update_date=getdate()
    FROM    dm_providers p
    JOIN    dm_roster_staging s
        ON  s.provider_npi=p.provider_npi
        AND s.practice_county<>ISNULL(p.practice_county,' ')
    -- practice_phone
    UPDATE  p
    SET     p.specialty=s.specialty, p.update_date=getdate()
    FROM    dm_providers p
    JOIN    dm_roster_staging s
        ON  s.provider_npi=p.provider_npi
        AND s.practice_phone<>ISNULL(p.practice_phone,' ')

    -- update patient data
    -- name
    UPDATE  p 
    SET     p.name=s.member_name, p.update_date=getdate()
    FROM    dm_patient p
    JOIN    dm_elig_staging s
        ON  s.member_id=p.mem_id
        AND s.member_name<>ISNULL(p.name,' ')
    -- address
    UPDATE  p 
    SET     p.address=s.member_address, p.update_date=getdate()
    FROM    dm_patient p
    JOIN    dm_elig_staging s
        ON  s.member_id=p.mem_id
        AND s.member_address<>ISNULL(p.address,' ')
    -- city
    UPDATE  p 
    SET     p.city=s.member_city, p.update_date=getdate()
    FROM    dm_patient p
    JOIN    dm_elig_staging s
        ON  s.member_id=p.mem_id
        AND s.member_city<>ISNULL(p.city,' ')
    -- state
    UPDATE  p 
    SET     p.state=s.member_state, p.update_date=getdate()
    FROM    dm_patient p
    JOIN    dm_elig_staging s
        ON  s.member_id=p.mem_id
        AND s.member_state<>ISNULL(p.state,' ')
    -- zip
    UPDATE  p 
    SET     p.zip=s.member_zip, p.update_date=getdate()
    FROM    dm_patient p
    JOIN    dm_elig_staging s
        ON  s.member_id=p.mem_id
        AND s.member_zip<>ISNULL(p.zip,' ')
    -- phone
    UPDATE  p 
    SET     p.phone=s.member_phone, p.update_date=getdate()
    FROM    dm_patient p
    JOIN    dm_elig_staging s
        ON  s.member_id=p.mem_id
        AND s.member_phone<>ISNULL(p.phone,' ')
    -- county
    UPDATE  p 
    SET     p.county=s.member_county, p.update_date=getdate()
    FROM    dm_patient p
    JOIN    dm_elig_staging s
        ON  s.member_id=p.mem_id
        AND s.member_county<>ISNULL(p.county,' ')
    -- dob
    UPDATE  p 
    SET     p.dob=CAST(CONVERT(datetime,CONVERT(char(8), s.member_dob)) AS DATE), p.update_date=getdate()
    FROM    dm_patient p
    JOIN    dm_elig_staging s
        ON  s.member_id=p.mem_id
        AND CONVERT(date,CONVERT(datetime,LEFT(s.member_dob,8)))<>ISNULL(p.dob,getdate())
    -- sex
    UPDATE  p 
    SET     p.sex=s.member_sex, p.update_date=getdate()
    FROM    dm_patient p
    JOIN    dm_elig_staging s
        ON  s.member_id=p.mem_id
        AND s.member_sex<>ISNULL(p.sex,' ')
    
    -- update dm_eligibility
    -- hpid
    UPDATE  e
    SET     e.hpid=s.member_hpid, e.update_date=getdate()
    FROM    dm_eligibility e
    JOIN    dm_elig_staging s
        ON  s.member_id=e.mem_id
        AND s.member_hpid<>ISNULL(e.hpid,' ')
    -- enroll_date
    UPDATE  e
    SET     e.enroll_date=CONVERT(datetime,CONVERT(char(8), s.member_enroll_date)), e.update_date=getdate()
    FROM    dm_eligibility e
    JOIN    dm_elig_staging s
        ON  s.member_id=e.mem_id
        AND CONVERT(datetime,CONVERT(char(8), s.member_enroll_date))<>ISNULL(e.enroll_date,getdate())
    -- provider_id
    UPDATE  e
    SET     e.provider_id=p.provider_id, e.update_date=getdate()
    FROM    dm_eligibility e
    JOIN    dm_elig_staging s
        ON  s.member_id=e.mem_id
    JOIN    dm_providers p
        ON  p.provider_npi=s.provider_npi
    WHERE   p.provider_id<>ISNULL(e.provider_id,0)
;
GO  

-- inserts and inactivates for patients and dm_providers
-- patients
IF OBJECT_ID ( 'mergePatients_FromStaging', 'P' ) IS NOT NULL   
    DROP PROCEDURE mergePatients_FromStaging;  
GO  
CREATE PROCEDURE mergePatients_FromStaging  
AS  
    SET NOCOUNT ON; 
    MERGE dm_patient AS p
    USING dm_elig_staging AS s
    ON p.mem_id=s.member_id
    WHEN NOT MATCHED BY TARGET
        THEN INSERT (mem_id, name, address, city, state, zip, county, phone, dob, sex, active, create_date, update_date, term_date)
                VALUES (member_id, member_name, member_address, member_city, member_state, member_zip, member_county, member_phone, cast(convert(datetime, LEFT(member_dob,8)) as date), member_sex, 1, getdate(), getdate(), NULL)
    WHEN NOT MATCHED BY SOURCE
        THEN UPDATE SET p.active=0, p.term_date=getdate(), p.update_date=getdate()
;
GO

-- dm_providers
IF OBJECT_ID ( 'mergedm_providers_FromStaging', 'P' ) IS NOT NULL   
    DROP PROCEDURE mergedm_providers_FromStaging;  
GO  
CREATE PROCEDURE mergedm_providers_FromStaging  
AS  
    SET NOCOUNT ON; 
	MERGE dm_providers AS p
    USING (SELECT DISTINCT provider_npi FROM dm_elig_staging) AS s
    ON p.provider_npi=s.provider_npi
    WHEN NOT MATCHED BY TARGET
        THEN INSERT (provider_npi, active)
                VALUES (provider_npi, 1)
    WHEN NOT MATCHED BY SOURCE
        THEN UPDATE SET p.active=0, p.term_date=getdate(), p.update_date=getdate()
;
GO

-- insert into member_month
IF OBJECT_ID ( 'updateMemberMonth_FromStaging', 'P' ) IS NOT NULL   
    DROP PROCEDURE updateMemberMonth_FromStaging;  
GO  
CREATE PROCEDURE updateMemberMonth_FromStaging  
AS 
    SET NOCOUNT ON;
    INSERT INTO dm_member_month
        SELECT  cast(convert(datetime, LEFT(monthcode,8)) as date), member_id, p.provider_id, s.healthplan, getdate(), getdate() 
        FROM    dm_elig_staging s
        JOIN    dm_providers p
            ON  s.provider_npi=p.provider_npi
            AND p.active=1
;
GO

-- dm_eligibility
IF OBJECT_ID ( 'mergedm_eligibility_FromStaging', 'P' ) IS NOT NULL   
    DROP PROCEDURE mergedm_eligibility_FromStaging;  
GO  
CREATE PROCEDURE mergedm_eligibility_FromStaging  
AS  
    SET NOCOUNT ON; 
	MERGE dm_eligibility AS p
    USING dm_elig_staging AS s
    ON p.mem_id=s.member_id
    WHEN NOT MATCHED BY TARGET
        THEN INSERT (mem_id, hpid, enroll_date, provider_id, active, create_date, update_date)
                VALUES (member_id, member_hpid, cast(convert(datetime, LEFT(member_enroll_date,8)) as date), NULL, 1, getdate(), getdate())
    WHEN NOT MATCHED BY SOURCE
        THEN UPDATE SET p.active=0, p.term_date=getdate(), p.update_date=getdate();
    
;
GO

-- inserts new claims
-- pharmacy
IF OBJECT_ID ( 'insertPharmacyClaims_FromStaging', 'P' ) IS NOT NULL   
    DROP PROCEDURE insertPharmacyClaims_FromStaging;  
GO  
CREATE PROCEDURE insertPharmacyClaims_FromStaging
AS  
    INSERT INTO dm_pharmacy_claims
        (reporting_period, member_pid, mem_id, provider_id, rend_prov_name
        , refer_prov_id, claim_no, service_from_date, service_to_date, process_date
        , ndc_code, rx_quantity, pot_code, claim_paid, claim_charge, lob_code, generic_ind
        , pharmacy_npi, pharmacy_name, service_type_code, create_date)
    SELECT    CAST(CONVERT(datetime,left(reporting_period,8)) AS date) reporting_period
            , member_pid
            , member_enroll_id
            , primary_prov_id
            , rend_provider
            , refer_prov_id
            , claim_no
            , CASE admit_date
				WHEN 0 THEN NULL
				ELSE CAST(CONVERT(datetime,left(service_from_date,8)) AS date)
			  END service_from_date
            , CASE discharge_date
				WHEN 0 THEN NULL
				ELSE CAST(CONVERT(datetime,left(service_to_date,8)) AS date)
			  END service_to_date
            , CASE process_date
				WHEN 0 THEN NULL
				ELSE CAST(CONVERT(datetime,left(process_date,8)) AS date) 
			  END process_date
            , ndc_code
            , rx_quantity
            , pot_code
            , claim_paid
            , claim_charge
            , lob_code
            , generic_ind
            , pharm_npi
            , pharm_name
			, service_type_code
            , getdate()
    FROM    dm_claims_staging
    WHERE   claim_type='R'   
;
GO

-- inpatient
IF OBJECT_ID ( 'insertInpatientClaims_FromStaging', 'P' ) IS NOT NULL   
    DROP PROCEDURE insertInpatientClaims_FromStaging;  
GO  
CREATE PROCEDURE insertInpatientClaims_FromStaging
AS  
    INSERT INTO dm_inpatient_claims
        (reporting_period, member_pid, mem_id, provider_id, rend_prov_name
        , refer_prov_id, claim_no, admit_date, discharge_date, process_date
        , admit_source_id, admit_dx, service_type_code, claim_paid, claim_charge, lob_code, pot_code
        , dx_code_1, dx_code_2, dx_code_3, dx_code_4, dx_code_5, dx_code_6, dx_code_7, dx_code_8
        , dx_code_9, proc_code_1, proc_code_2, proc_code_3, proc_code_4, proc_code_5, proc_code_6
        , drg_no, create_date)
    SELECT    CAST(CONVERT(datetime,left(reporting_period,8)) AS date) reporting_period
            , member_pid
            , member_enroll_id
            , primary_prov_id
            , rend_provider
            , refer_prov_id
            , claim_no
            , CASE admit_date
				WHEN 0 THEN NULL
				ELSE CAST(CONVERT(datetime,left(admit_date,8)) AS date)
			  END admit_date
            , CASE discharge_date
				WHEN 0 THEN NULL
				ELSE CAST(CONVERT(datetime,left(discharge_date,8)) AS date)
			  END discharge_date
            , CASE process_date
				WHEN 0 THEN NULL
				ELSE CAST(CONVERT(datetime,left(process_date,8)) AS date) 
			  END process_date
            , admit_source
            , admit_dx
			, service_type_code
            , claim_paid
            , claim_charge
            , lob_code
            , pot_code
            , dx_code_1
            , dx_code_2
            , dx_code_3
            , dx_code_4
            , dx_code_5
            , dx_code_6
            , dx_code_7
            , dx_code_8
            , dx_code_9
            , proc_code_1
            , proc_code_2
            , proc_code_3
            , proc_code_4
            , proc_code_5
            , proc_code_6
            , drg_no
            , getdate()
    FROM    dm_claims_staging
    WHERE   claim_type<>'R' AND pot_code IN ('1','X','Z')
;
GO

-- other
IF OBJECT_ID ( 'insertOtherClaims_FromStaging', 'P' ) IS NOT NULL   
    DROP PROCEDURE insertOtherClaims_FromStaging;  
GO  
CREATE PROCEDURE insertOtherClaims_FromStaging
AS  
    INSERT INTO dm_other_claims
        (reporting_period, member_pid, mem_id, provider_id, rend_prov_name
        , refer_prov_id, claim_no, service_from_date, service_to_date, process_date
        , admit_source_id, admit_dx, service_type_code, claim_paid, claim_charge, lob_code, pot_code
        , dx_code_1, dx_code_2, dx_code_3, dx_code_4, dx_code_5, dx_code_6, dx_code_7, dx_code_8
        , dx_code_9, proc_code_1, proc_code_2, proc_code_3, proc_code_4, proc_code_5, proc_code_6
        , drg_no, create_date)
    SELECT    CAST(CONVERT(datetime,left(reporting_period,8)) AS date) reporting_period
            , member_pid
            , member_enroll_id
            , primary_prov_id
            , rend_provider
            , refer_prov_id
            , claim_no
            , CASE service_from_date
				WHEN 0 THEN NULL
				ELSE CAST(CONVERT(datetime,left(service_from_date,8)) AS date)
			  END service_from_date
            , CASE service_to_date
				WHEN 0 THEN NULL
				ELSE CAST(CONVERT(datetime,left(service_to_date,8)) AS date)
			  END service_to_date
            , CASE process_date
				WHEN 0 THEN NULL
				WHEN NULL THEN NULL
				ELSE CAST(CONVERT(datetime,left(process_date,8)) AS date) 
			  END 
			  process_date
            , admit_source
            , admit_dx
			, service_type_code
            , claim_paid
            , claim_charge
            , lob_code
            , pot_code
            , dx_code_1
            , dx_code_2
            , dx_code_3
            , dx_code_4
            , dx_code_5
            , dx_code_6
            , dx_code_7
            , dx_code_8
            , dx_code_9
            , proc_code_1
            , proc_code_2
            , proc_code_3
            , proc_code_4
            , proc_code_5
            , proc_code_6
            , drg_no
            , getdate()
    FROM    dm_claims_staging
    WHERE   claim_type<>'R' AND (pot_code <> '1' AND pot_code <> 'X' AND pot_code <> 'Z')
;
GO

-- run stored procs proc
IF OBJECT_ID ( 'run_full_merge', 'P' ) IS NOT NULL   
    DROP PROCEDURE run_full_merge;  
GO  
CREATE PROCEDURE run_full_merge
AS
    SET NOCOUNT ON;
    -- Set 'filters' for Humana elig files. These will need to be incorporated into the Python scripts eventually, since this process is pretty stupid.
    DELETE FROM dm_elig_staging WHERE PRO_LOB='ALT' OR PRO_LOB='HHP'
    DELETE FROM dm_elig_staging WHERE GK_ADJ_CD<>'' OR GK_ADJ_CD IS NOT NULL -- Dump patient records that should be filtered out per Humana
    UPDATE dm_elig_staging SET healthplan='H' -- set all healthplans to 'Humana' for now.

    -- Create exec plan for other merges/updates
    EXEC mergedm_providers_FromStaging      -- providers first, to set provider_ids for other procs
    EXEC mergePatients_FromStaging          -- patients next
    EXEC mergedm_eligibility_FromStaging    -- elig
    EXEC updateMemberMonth_FromStaging      -- member_month last
    EXEC update_FromStaging                 -- finally, update existing values that haven't been added or replaced
    EXEC insertPharmacyClaims_FromStaging   -- begin claims inserts with pharma
    EXEC insertInpatientClaims_FromStaging
    EXEC insertOtherClaims_FromStaging
    -- return some counts
    SELECT CAST(COUNT(CASE WHEN active=1 THEN mem_id END) as varchar)+' elig_members' counts from dm_eligibility
    UNION ALL
    SELECT CAST(COUNT(DISTINCT member_id) as varchar)+' patients in staging' counts from dm_elig_staging
    UNION ALL
    SELECT CAST(COUNT(CASE WHEN active=1 THEN provider_id END) as varchar)+' providers' counts from dm_providers
    UNION ALL
    SELECT CAST(COUNT(DISTINCT provider_npi) as varchar)+' providers in staging' counts from dm_elig_staging
    
;
GO