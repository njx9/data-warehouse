IF OBJECT_ID('dm_elig_staging', 'U') IS NOT NULL
    DROP TABLE dm_elig_staging;
CREATE  TABLE dm_elig_staging (
	  monthcode	            int
    , lob_class             varchar(3)
    , provider_name         varchar(40)
    , provider_npi          int
    , provider_contract     varchar(20)
    , member_name           varchar(35)
    , member_id             bigint
    , member_hpid           varchar(15)
    , member_address        varchar(50)
    , member_city           varchar(20)
    , member_state          varchar(2)
    , member_zip            varchar(9)
    , member_county         varchar(15)
    , member_phone          varchar(15)
    , member_dob            int
    , member_dod            int
    , member_sex            varchar(1)
    , member_enroll_date    int
    , healthplan            varchar(1)
    , pro_lob               varchar(3)
    , gk_adj_cd             varchar(1)
);
GO

IF OBJECT_ID('dm_roster_staging', 'U') IS NOT NULL
    DROP TABLE dm_roster_staging;
CREATE TABLE dm_roster_staging (
      provider_npi      int
    , region            varchar(10)
    , contract_entity   varchar(15)
    , eff_date          date
    , type              varchar(25)
    , specialty         varchar(60)
    , practice_name     varchar(50)
    , practice_npi      int
    , practice_address  varchar(40)
    , practice_city     varchar(20)
    , practice_state    varchar(2)
    , practice_zip      int
    , practice_county   varchar(10)
    , practice_phone    varchar(10)
    , practice_tin      varchar(10)
    , network           varchar(1)
);
GO

IF OBJECT_ID('dm_claims_staging', 'U') IS NOT NULL
    DROP TABLE dm_claims_staging;
CREATE TABLE dm_claims_staging (
      reporting_period  int             -- Column ER / YYYYMMDD format for date
    , member_pid        varchar(15)     -- Column EP
    , member_enroll_id  bigint          -- Column O
    , patient_name      varchar(30)     -- Column S
    , patient_dob       int             -- Column U / YYYYMMDD format for date
    , primary_prov_id   varchar(10)     -- Column AQ provider_id matches GK id
    , rend_prov_id      varchar(11)     -- Column AR
    , rend_prov_name    varchar(30)     -- Column AS
    , rend_prov_zip	    int		        -- Column BA
    , gk_provider_name  varchar(100)    -- Column EK
    , gk_prov_contract  varchar(25)     -- Column EQ
    , refer_prov_id     varchar(10)     -- Column BB
    , claim_no          bigint          -- Column J
    , claim_type        varchar(1)      -- Column K
    , rend_prov_type    varchar(2)      -- Column EO
    , admit_source      varchar(1)      -- Column X
    , admit_date        int             -- Column Y / YYYYMMDD format for date
    , discharge_date    int             -- Column AC / YYYYMMDD format for date
    , admit_dx          varchar(5)      -- Column AB
    , discharge_status  varchar(1)      -- Column AD
    , NDC_Code          varchar(12)     -- Column AE
    , rx_quantity       int             -- Column AF
    , service_from_date int             -- Column CJ / YYYYMMDD format for date
    , service_to_date   int             -- Column CK / YYYYMMDD format for date
    , process_date      int             -- Column AH / YYYYMMDD format for date
    , service_type_code varchar(20)     -- Column DE / Should also use rev codes from NA data mart
    , procedure_desc    varchar(100)    -- Column GA
    , service_units     real            -- Column CM
    , dx_code_1         varchar(10)     -- Column BF
    , dx_code_2         varchar(10)     -- Column BG
    , dx_code_3         varchar(10)     -- Column BH
    , dx_code_4         varchar(10)     -- Column BI
    , dx_code_5         varchar(10)     -- Column BJ
    , dx_code_6         varchar(10)     -- Column BK
    , dx_code_7         varchar(10)     -- Column BL
    , dx_code_8         varchar(10)     -- Column BM
    , dx_code_9         varchar(10)     -- Column BN
    , proc_code_1       varchar(7)      -- Column BX
    , proc_code_2       varchar(7)      -- Column BX
    , proc_code_3       varchar(7)      -- Column BX
    , proc_code_4       varchar(7)      -- Column BX
    , proc_code_5       varchar(7)      -- Column BX
    , proc_code_6       varchar(7)      -- Column BX
    , DRG_no            varchar(3)      -- Column CL
    , pot_code          varchar(1)      -- Column CN / place of treatment code
    , claim_charge      money           -- Column CO
    , claim_paid        money           -- Column CR
    , claim_discount    money           -- Column CX
    , lob_code          varchar(3)      -- Column DX
    , generic_ind       varchar(1)      -- Column EX
    , pharm_npi         int             -- Column FE
    , pharm_name        varchar(20)     -- Column FF
);
GO

-- pharmacy claims (claim_type = R)
IF OBJECT_ID('dm_pharmacy_claims', 'U') IS NOT NULL
    DROP TABLE dm_pharmacy_claims;
CREATE TABLE dm_pharmacy_claims (
      reporting_period      date
    , member_pid            varchar(15)
    , mem_id                bigint
    , provider_id           varchar(20)
    , rend_prov_name        varchar(100)
    , refer_prov_id         varchar(10)
    , claim_no              bigint
    , service_from_date     date
    , service_to_date       date
    , process_date          date
    , ndc_code              bigint
    , rx_quantity           int
    , pot_code              varchar(1)
    , claim_paid            money
    , claim_charge          money
    , lob_code              varchar(3)
    , generic_ind           varchar(1)
    , pharmacy_npi          int
    , pharmacy_name         varchar(20)
    , service_type_code     varchar(20)
    , create_date           datetime
);
GO

-- inpatient claims (POT=1,X,Z and claim_type<>R)
IF OBJECT_ID('dm_inpatient_claims','U') IS NOT NULL
    DROP TABLE dm_inpatient_claims;
CREATE TABLE dm_inpatient_claims (
      reporting_period      date
    , member_pid            varchar(15)
    , mem_id                bigint
    , provider_id           varchar(20)
    , rend_prov_name        varchar(100)
    , refer_prov_id         varchar(10)
    , claim_no              bigint
    , claim_paid            money
    , claim_charge          money
    , lob_code              varchar(3)
    , pot_code              varchar(1)
    , admit_date            date
    , discharge_date        date
    , process_date          date
    , admit_source_id       varchar(1)
    , admit_dx              varchar(5)
    , service_type_code     varchar(20)
    , dx_code_1             varchar(10)
    , dx_code_2             varchar(10)
    , dx_code_3             varchar(10)
    , dx_code_4             varchar(10)
    , dx_code_5             varchar(10)
    , dx_code_6             varchar(10)
    , dx_code_7             varchar(10)
    , dx_code_8             varchar(10)
    , dx_code_9             varchar(10)
    , proc_code_1           varchar(7)
    , proc_code_2           varchar(7)
    , proc_code_3           varchar(7)
    , proc_code_4           varchar(7)
    , proc_code_5           varchar(7)
    , proc_code_6           varchar(7)
    , DRG_no                varchar(3)
    , create_date           datetime
)

-- other claims (POT<>1,X,Z and claim_type<>R)
IF OBJECT_ID('dm_inpatient_claims','U') IS NOT NULL
    DROP TABLE dm_other_claims;
CREATE TABLE dm_other_claims (
      reporting_period      date
    , member_pid            varchar(15)
    , mem_id                bigint
    , provider_id           varchar(20)
    , rend_prov_name        varchar(100)
    , refer_prov_id         varchar(10)
    , claim_no              bigint
    , claim_paid            money
    , claim_charge          money
    , lob_code              varchar(3)
    , pot_code              varchar(1)
    , service_from_date     date
    , service_to_date       date
    , process_date          date
    , admit_source_id       varchar(1)
    , admit_dx              varchar(5)
    , service_type_code     varchar(20)
    , dx_code_1             varchar(10)
    , dx_code_2             varchar(10)
    , dx_code_3             varchar(10)
    , dx_code_4             varchar(10)
    , dx_code_5             varchar(10)
    , dx_code_6             varchar(10)
    , dx_code_7             varchar(10)
    , dx_code_8             varchar(10)
    , dx_code_9             varchar(10)
    , proc_code_1           varchar(7)
    , proc_code_2           varchar(7)
    , proc_code_3           varchar(7)
    , proc_code_4           varchar(7)
    , proc_code_5           varchar(7)
    , proc_code_6           varchar(7)
    , DRG_no                varchar(3)
    , create_date           datetime
)

IF OBJECT_ID('dm_providers', 'U') IS NOT NULL
    DROP TABLE dm_providers;
CREATE TABLE dm_providers (
      provider_id       int IDENTITY(1,1) PRIMARY KEY
    , provider_npi      int NOT NULL
    , provider_name     varchar(40)
    , type              varchar(25) -- from chn roste)
    , specialty         varchar(60) -- from chn roste)
    , practice_name     varchar(50) -- from chn roste)
    , practice_npi      int         -- from chn roster
    , region            varchar(10) -- from chn roste)
    , contract_entity   varchar(15) -- from chn roste)
    , practice_tin      varchar(10) -- from chn roste)
    , network           varchar(1)  -- from chn roste)
    , practice_address  varchar(40) -- from chn roste)
    , practice_city     varchar(20) -- from chn roste)
    , practice_state    varchar(2)  -- from chn roste)
    , practice_zip      int         -- from chn roster
    , practice_county   varchar(10) -- from chn roste)
    , practice_phone    varchar(10) -- from chn roste)
    , provider_contract varchar(20)
    , healthplan        varchar(1)
    , active            int
    , CREATE_date       date
    , update_date       date
    , term_date         date
);
GO

IF OBJECT_ID('dm_eligibility', 'U') IS NOT NULL
    DROP TABLE dm_eligibility;
CREATE  TABLE dm_eligibility (
      mem_id        bigint IDENTITY(1,1) PRIMARY KEY
    , hpid          varchar(15)
    , enroll_date   date
    , provider_id   int
    , active        int
    , CREATE_date   date
    , update_date   date
    , term_date     date
);
GO

IF OBJECT_ID('dm_patient', 'U') IS NOT NULL
    DROP TABLE dm_patient;
CREATE  TABLE dm_patient (
      mem_id        bigint IDENTITY(1,1) PRIMARY KEY
    , name          varchar(35)
    , address       varchar(50)
    , city          varchar(20)
    , state         varchar(2)
    , zip           varchar(9)
    , county        varchar(15)
    , phone         varchar(15)
    , dob           date
    , sex           varchar(2)
    , active        int
    , CREATE_date   date
    , update_date   date
    , term_date     date
);
GO

IF OBJECT_ID('dm_member_month', 'U') IS NOT NULL
    DROP TABLE dm_member_month;
CREATE  TABLE dm_member_month (
      monthcode     date
    , mem_id        bigint
    , provider_id   int
    , healthplan    varchar(1)
    , CREATE_date   date
    , update_date   date
)

/*-------------------------------------------------------------------
                    DIM TABLE CREATION
-------------------------------------------------------------------*/

IF OBJECT_ID('dm_place_of_treatment_dim', 'U') IS NOT NULL
    DROP TABLE dm_place_of_treatment_dim;
CREATE TABLE dm_place_of_treatment_dim (
      code          varchar(2)
    , description   varchar(55)
);
GO

INSERT INTO dm_place_of_treatment_dim (code, description)
    VALUES   ('0','Other - Not Classified HCFA')
           , ('1','Inpatient Hospital')
           , ('2','Outpatient Hospital')
           , ('3','Physician''s Office')
           , ('4','SNF')
           , ('5','N/A')
           , ('6','N/A')
           , ('7','Nursing Home')
           , ('8','Extended Care Facility')
           , ('9','Ambulance')
           , ('X','Inpatient Hospital')
           , ('Z','Inpatient Hospital')
           , ('A','Independent Lab')
           , ('B','Custodial Care Facility')
           , ('D','Public Health Clinic')
           , ('F','Inpatient Psychiatric Facility')
           , ('G','ESRD Facility')
           , ('H','Hospice')
           , ('I','Ambulatory Surgical Center')
           , ('N','Birthing Center')
           , ('R','Emergency Room')
           , ('U','Urgent Care Facility')
           , ('W','Outpatient Hospital');
GO

IF OBJECT_ID('dm_claim_type_dim', 'U') IS NOT NULL
    DROP TABLE dm_claim_type_dim;
CREATE TABLE dm_claim_type_dim (
      code          varchar(2)
    , description   varchar(55)
);
GO

INSERT INTO dm_claim_type_dim (code, description)
    VALUES   ('H','Hospital')
           , ('P','Physician')
           , ('R','Pharmacy')
           , ('W','zz Withholds')
           , ('V','zz Voids')
           , ('X','zz Not in CAS Medclaim');
GO

IF OBJECT_ID('dm_provider_type_dim', 'U') IS NOT NULL
    DROP TABLE dm_provider_type_dim;
CREATE TABLE dm_provider_type_dim (
      code          varchar(2)
    , description   varchar(55)
);
GO

INSERT INTO dm_provider_type_dim (code, description)
    VALUES  ('AC','Acupuncturist')
            , ('AD','Alcohol/Drug Abuse Counselor')
            , ('AN','Anesthesiologist')
            , ('AU','Audiologist')
            , ('CD','Certified Dentistry')
            , ('CS','Christian Science Practitioner')
            , ('DC','Diagnostic Chiropractor')
            , ('DD','Dentist')
            , ('DO','Osteopath')
            , ('DP','Podiatrist')
            , ('DS','Dental Surgeon')
            , ('HF','Health Fair')
            , ('HH','Home Health Provider')
            , ('IC','Intermediate Care Facility')
            , ('IL','Independent Lab')
            , ('IT','Infusion Therapist')
            , ('KC','Dialysis Center')
            , ('MD','Doctor')
            , ('MF','Minor ER/ER Center Physician')
            , ('NA','Nurse Anesthetist')
            , ('ND','Naturopath')
            , ('NL','Not Listed')
            , ('NM','Nurse Midwife')
            , ('NP','Nurse Practitioner')
            , ('NS','Clinical Nurse Specialist')
            , ('OD','Ophthalmologist')
            , ('ON','Optician')
            , ('OP','Optometrist')
            , ('OT','Occupational Therapist')
            , ('PA','Physician’s Assistant')
            , ('PC','Pain Center')
            , ('PS','Psychologist')
            , ('PT','Physical Therapist')
            , ('RN','Registered Nurse')
            , ('SA','Surgical Assistant')
            , ('SG','Surgeon')
            , ('SP','Other Specialist')
            , ('SS','Special Services')
            , ('ST','Speech Therapist')
            , ('SW','Social Worker/Counselor')
            , ('UC','Urgent Care')
            , ('XR','Radiologist');
GO

IF OBJECT_ID('dm_admit_source_dim', 'U') IS NOT NULL
    DROP TABLE dm_admit_source_dim;
CREATE TABLE dm_admit_source_dim (
      code          varchar(2)
    , description   varchar(55)
);
GO

INSERT INTO dm_admit_source_dim (code, description)
    VALUES    ('1','Physician Referral')
            , ('2','Clinical Referral')
            , ('3','HMO Referral')
            , ('4','Transfer from Facility')
            , ('5','Transfer from SNF')
            , ('6','Transfer from another health care facility')
            , ('7','Emergency Room')
            , ('8','Court or law enforced')
            , ('9','Information not available')
            , ('A','Transfer from a critical access hospital (CAH)')
            , ('B','Transfer from another home health agency')
            , ('C','Readmission to same home health agency')
            , ('D','Transfer from hosptial inpatient in the same facility');
GO

IF OBJECT_ID('dm_discharge_status_dim', 'U') IS NOT NULL
    DROP TABLE dm_discharge_status_dim;
CREATE TABLE dm_discharge_status_dim (
      code          varchar(2)
    , description   varchar(155)
);
GO

INSERT INTO dm_discharge_status_dim (code, description)
    VALUES    ('1','Discharge to home (routine) or self care')
            , ('2','Discharge/transfer to short-term general hospital')
            , ('3','Discharge/transfer to Skilled Nursing Facility (SNF)')
            , ('4','Discharge/transfer to Intermediate Care Facility (ICF)')
            , ('5','Discharge/transfer to another type institution')
            , ('6','Discharge/transfer to home under care of organized healthcare organization')
            , ('7','Left against medical advice')
            , ('9','Admitted as inpatient to this hospital')
            , ('10','Discharge/transfer to community mental health care facility')
            , ('20','Expired')
            , ('21','Discharged/transferred to court/law enforcement')
            , ('30','Still patient')
            , ('40','Expired at home')
            , ('41','Expired in Medical facility')
            , ('42','Expired - place unknown')
            , ('50','Discharged to Hospice – home')
            , ('51','Discharged to Hospice – medical facility')
            , ('61','Discharge/transfer within facility to a hospital-based Medicare-approved swing bed')
            , ('62','Discharge/transfer to inpatient rehabilitation facility or rehabilitation distinct part unit of a hospital')
            , ('63','Discharge/transfer to a Long-Term Care Hospital (LTCH)')
            , ('64','Discharge/transfer to a nursing facility certified under Medicaid but not Medicare')
            , ('65','Discharge/transfer to a psychiatric facility or a psychiatric distinct part unit of a hospital')
            , ('66','Discharge/transfer to a Critical Access Hospital (CAH)')
            , ('70','Discharge/transfer to another type of healthcare institution not defined elsewhere in the code list')
            , ('71','Discharge to another institution for outpatient service')
            , ('72','Discharge/transfer/referral to this institution for outpatient service as specified by discharge plan care')
            , ('82','Discharged/transferred to a short-term general hospital for inpatient care with a planned acute care hospital inpatient readmission')
            , ('85','Discharged/transferred to a designated cancer center or children’s hospital with a planned acute care hospital inpatient readmission')
            , ('86','Discharged/transferred to home under care of organized home health service organization with a planned acute care hospital inpatient readmission')
            , ('90','Discharged/transferred to an IRF including rehabilitation distinct part units of a hospital with a planned acute care hospital inpatient readmission')
            , ('91','Discharged/transferred to a Medicare certified LTCH with a planned acute care hospital inpatient readmission')
            , ('93','Discharged/transferred to a psychiatric distinct part unit of a hospital with a planned acute care hospital inpatient readmission')
            , ('94','Discharged/transferred to a CAH with a planned acute care hospital inpatient readmission')
            , ('98','Close Workers'' Compensation Case. (Inactive by CMS on October 16, 2003)')
            , ('99','Continued stay denial (inactive by CMS on October 16, 2003)');
GO

IF OBJECT_ID('dm_hum_serv_types_dim', 'U') IS NOT NULL
    DROP TABLE dm_hum_serv_types_dim;
CREATE TABLE dm_hum_serv_types_dim (
      code      varchar(6)
    , description   varchar(185)
);
GO

INSERT INTO dm_hum_serv_types_dim (code, description)
    VALUES    ('ADDPT','ADDITIONAL PAYMENT')
            , ('ADJST','ADJUSTMENT')
            , ('ADPY','ADJUSTMENT CLAIMS')
            , ('AMB','AMBULANCE')
            , ('AMBAIR','AIR AMBULANCE')
            , ('AMBEX','AMBULANCE EXCEPTION')
            , ('ANC','ANCILLARY CHARGES')
            , ('ANES','ANESTHESIA')
            , ('ANTIR','ANTIREFLECTIVE COAT')
            , ('AONMV','PHYSICIANS VISITS')
            , ('ARX','PRESCRIPTION DRUGS')
            , ('AUSTIM','AUSTIM')
            , ('BCPIL','BIRTH CONTROL PILLS')
            , ('BCRX','ORAL CONTRACEPTIVES')
            , ('BIFO','BIFOCALS')
            , ('BL','BLOOD')
            , ('BLOOD','OUTPATIENT BLOOD')
            , ('BONUS','BONUS')
            , ('CAMB','AMBULANCE')
            , ('CANES','ANESTHESIA')
            , ('CBL','BLOOD')
            , ('CEEG','ELECTROENCEPHALAGRAM')
            , ('CEKG','ELECTROCARDIOGRAM')
            , ('CER','EMERGENCY ROOM')
            , ('CERMD','EMER RM MD')
            , ('CHECK','RETURNED CHECK')
            , ('CHEMO','CHEMOTHERAPY TREATMENT')
            , ('CHIRO','CHIROPRACTIC REVIEW')
            , ('CHSAV','AUDIT OF BILL')
            , ('CICU','INTENSIVE CARE UNIT')
            , ('CINJ','INJECTIONS')
            , ('CLAB','LABORATORY')
            , ('CMISC','MISCELLANEOUS')
            , ('CMISCR','MISC ROOM & BOARD')
            , ('CNKTC','COLD TX CONTACT KIT')
            , ('CNKTH','HEAT TX CONTACT KIT')
            , ('CNURS','NURSERY')
            , ('CO','CONSULTATION')
            , ('COBCK','COB CHECK RETURNED')
            , ('CODAY','MED COINSURANCE DAYS 61-90')
            , ('COINS','COINSURANCE CREDIT')
            , ('CON','H	HARD CONTACTS')
            , ('CON','S	SOFT CONTACTS')
            , ('CON','H	HARD CONTACTS')
            , ('CON','S	SOFT CONTACT')
            , ('CONTCT','CONTACT LENS/SINGLE')
            , ('COR','OPERATING/RECOV ROOM')
            , ('COSH','OUTPATIENT SURG HOSP')
            , ('CPAT','PRE ADMIT TESTING')
            , ('CPHAR','PHARMACY')
            , ('CPR','PRIVATE ROOM')
            , ('CPT','PHYSICAL THERAPY')
            , ('CRAD','RADIOLOGY')
            , ('CREDT','DEDUCTIBLE CREDIT')
            , ('CRESP','RESPIRATORY THERAPY')
            , ('CSP','SEMI PRIVATE ROOM')
            , ('CSSO','SECOND SURG OPINION')
            , ('CSUP','SUPPLIES')
            , ('CTACT','CONTACT LENSE')
            , ('CTCT','OTHER CONTACT LENSES')
            , ('CTSO','THIRD SURGICAL OPIN')
            , ('CWD','WARD')
            , ('DAYTRT','DAY TRMT / PHYSICIAN')
            , ('DED','NON PAR DEDUCTIBLE')
            , ('DED','B	MED PART B DED')
            , ('DEDB','MED PART B DED')
            , ('DEDBER','MED DED FROM ER ROOM')
            , ('DEDBOV','MED PART B DED OFFICE VISIT')
            , ('DEDC','HUMANA PART B DEDUCT')
            , ('DEDCT','PRIOR CARRIER DEDUCTIBLE')
            , ('DETOX','ALCOHOL/DRUG ABUSE/DETOXIFICATION SERVICES')
            , ('DGCAP','DRG CAP COST REIMB')
            , ('DGDSH','FACILITY CHARGE(DRG)')
            , ('DGIME','FACILITY CHARGE(DRG)')
            , ('DGOUT','DRG OUTLIER REIMB')
            , ('DGTRN','FACILITY CHARGE(DRG)')
            , ('DGXXX','FACILITY CHARGE(DRG)')
            , ('DISPS','DISPENSING FEE')
            , ('DISRE','REDUCED DISCENTIVE')
            , ('DME','DURABLE MEDICAL EQUIPMENT')
            , ('DNTL','DENTAL SURGERY')
            , ('DNTL1','ACC TREAT W/IN 48 HR')
            , ('DNTL2','ACC TREAT AFTER 48HR')
            , ('DNTL3','ACC TREA AFTER 3MONT')
            , ('DONOR','DONOR COSTS')
            , ('DRGDSH','FACILITY CHARGE(DRG)')
            , ('DRGIME','FACILITY CHARGE(DRG)')
            , ('DRGTRN','FACILITY CHARGE(DRG)')
            , ('DRUGS','DRUGS MAY BE LEGEND OR GENERIC')
            , ('DXL','UPDATE XL BENEFIT')
            , ('EAR','ROUTINE EAR EXAM')
            , ('EARTES','ROUTINE EAR EXAM')
            , ('ECF','EXTENDED CARE FACILITY (ECF)')
            , ('ECFA','ECF SKILL NURS ADD''L DAY')
            , ('EEG','ELECTROENCEPHALOGRAPHY')
            , ('EFARE','CTR EXCEL TRANSPORT')
            , ('EKG','ELECTROCARDIOGRAM')
            , ('ELODGE','CTR EXCEL LODGING')
            , ('EMEAL','MEAL EXPENES')
            , ('EQPUR','EQUIPMENT PURCHASE')
            , ('EQRNT','EQUIPMENT RENTAL CHARGE')
            , ('ER','EMERGENCY ROOM')
            , ('ERIPA','EMERGENCY SERVICES')
            , ('ERMD','EMERGENCY ROOM PHYSICIAN')
            , ('EXEC','SPECIAL PLAN (GROUP SPECIFIC)')
            , ('EXECD','EXEC DENTAL PLAN')
            , ('EYEGL','MED EYE GLASS BEN')
            , ('FARE','TRANSPORTATION')
            , ('FEEADJ','FEE SCHEDULE ADJMT.')
            , ('FICA','FEDERAL INSURANCE CONTRIBUTION ACT (FICA) WITHHOLDINGS')
            , ('FIMPAC','WISDOM TEETH EXTRACT')
            , ('FIT','FIT WITHHOLDINGS')
            , ('FMPL','FAMILY PLANNING BENEFIT')
            , ('FRAM1','FRAMES PRICED TO $54')
            , ('FRAM2','FRAMES $55 TO $74')
            , ('FRAM3','FRAMES OVER $74')
            , ('FRAME','EYEGLASS FRAME')
            , ('FRAME2','2ND PR GLASSES')
            , ('FSPS','PSYCHRIATRIC RISK')
            , ('FTINT','FASHION TINT LENSES')
            , ('GENRX','GENERIC DRUGS')
            , ('GRADI','GRADIENT TINT')
            , ('GRXMNT','GENERIC DRUG MAINTENANCE')
            , ('HCAP','PCP CAP DEDUCTION')
            , ('HEART','HEART BENEFIT')
            , ('HEMO','HEMOPHILIAC SERVIES')
            , ('HHA','HOME HEALTH AGENCY')
            , ('HHAP','HUMANA HOSPITAL ASSISTS PLAN')
            , ('HHBEP','HUMANA BENEFIT PLAN (INPATIENT HOSPITAL CHARGES)')
            , ('HHM','MATERNITY INCENTIVE')
            , ('HHN','HOME HEALTH NURSING')
            , ('HMIC','MATERNITY INCENTIVE')
            , ('HOSP','HOSPITAL CHARGES')
            , ('HRX','TAKE HOME DRUGS')
            , ('HSB','BEREAVEMENT COUNSEL')
            , ('HSP','INPATIENT HOSPICE CARE')
            , ('HSPC','HOSPICE CARE')
            , ('HSPCO','HOSPICE CARE OUTPATIENT')
            , ('I','INDIVIDUAL')
            , ('ICU','INTENSIVE CARE UNIT')
            , ('IDEMN','HOSPITAL IDENMNITY')
            , ('IMAGE','CROSS REFERENCE')
            , ('INDEMN','HOSPITAL INDEMNITY')
            , ('INJ','INJECTIONS')
            , ('INTERE','INTEREST')
            , ('INTRST','MED HMO INTEREST PMT')
            , ('INTST','INTEREST PROVIDERS')
            , ('IPA','IPA RISK')
            , ('IVT','INFUSION THERAPY')
            , ('LAB','LABORATORY')
            , ('LDAY','BEYOND LIFETIME RESESRVE DAY')
            , ('LENSE','LENSE/SINGLE')
            , ('LENTI','LENTICULAR LENS')
            , ('LENTIC','LENTICULAR LENS')
            , ('LITHO','LITHOTRIPSY BENEFIT')
            , ('LODGE','TRANSPLANT LODGING')
            , ('LPN','LICENSED PRACTITIONER NURSE')
            , ('LT','LETTER')
            , ('MAIL','RECEIVED MAIL')
            , ('MAMB','AMBULANCE')
            , ('MANES','ANESTHESIA')
            , ('MAT','ANTEPARTUM CARE')
            , ('MATREB','MATERNITY REBATE')
            , ('MBL','BLOOD')
            , ('MCM','MEDICAL CASE MANAGEMENT')
            , ('MCMDME','MEDICAL CASE MANAGEMENT DURABLE MEDICAL EQUIPMENT (DME)')
            , ('MCMECF','MEDICAL CASE MANAGEMENT EXTENDED CARE FACILITY (ECF)')
            , ('MCMHHA','MEDICAL CASE MANAGEMENT HOME HEALTH AGENCY (HHA)')
            , ('MCMHHN','MEDICAL CASE MANAGEMENT HOME HEALTH NURSE (HHN)')
            , ('MCMIVT','MEDICAL CASE MANAGEMENT INFUSION THERAPY')
            , ('MCMOMS','MEDICAL CASE MANAGEMENT OUTPATIENT SERVICES')
            , ('MCMREH','MEDICAL CASE MANAGEMENT REHABILITATION SERVICES')
            , ('MCMRN','MEDICAL CASE MANAGEMENT REGISTERED NURSE')
            , ('MDME','DURABLE MED EQUIP')
            , ('MDNTL','DENTAL SURGERY')
            , ('MECF','EXTEND CARE FACILITY')
            , ('MEDCDX','INPATIENT HOSPITAL DAYS')
            , ('MEDCDY','INPATIENT HOSPITAL DAYS')
            , ('MEDED','MEDICARE INPATIENT DEDUCTIBLE')
            , ('MEEG','ELECTROENCEPHALAGRAM')
            , ('MEKG','ELECTROCARDIOGRAM')
            , ('MER','EMERGENCY ROOM')
            , ('MERMD','EMERG RM MD')
            , ('MHHA','HOME HEALTH AGENCY')
            , ('MHHN','HOME HEALTH NURSING')
            , ('MHSB','HOSPICE BEREAVE COUN')
            , ('MHSPC','HOSPICE CARE')
            , ('MHSPCO','HOSPICE CARE OUTPT')
            , ('MICU','INTENSIVE CARE UNIT')
            , ('MINJ','INJECTIONS')
            , ('MISC','MISCELLANEOUS')
            , ('MISC1','MISCELLANEOUS')
            , ('MISCRB','MISCELLANEOUS ROOM & BOARD')
            , ('MLAB','LABORTORY')
            , ('MMISC','MISCELLANEOUS')
            , ('MMISCR','MISC ROOM & BOARD')
            , ('MNURS','NURSERY')
            , ('MOMS','OTHER MEDICAL SERV')
            , ('MOR','OPERATING/RECOV ROOM')
            , ('MOSH','OUTPATIENT SURG HOSP')
            , ('MPAT','PRE ADMIT TESTING')
            , ('MPHAR','PHARMACY')
            , ('MPR','PRIVATE ROOM')
            , ('MPROS','PROSTHESIS')
            , ('MPT','PHYSICAL THERAPY')
            , ('MQCM','MEDICAL CASE MGMT')
            , ('MRAD','RADIOLOGY')
            , ('MRESP','RESPIRATORY THERAPY')
            , ('MRN','REGISTERED NURSE')
            , ('MRX','PRESCRIPTION DRUGS')
            , ('MSCS','MISCELLANEOUS')
            , ('MSH','MEDICARE SUPP HOSP')
            , ('MSHLR','MED SUPP HOSP RESERV')
            , ('MSINV','MISSING/INVALID CPT CODE ON PAPER CLAIM')
            , ('MSP','SEMI PRIVATE ROOM')
            , ('MSSO','SECOND SURD OPINION')
            , ('MSUP','SUPPLIES')
            , ('MTSO','THIRD SURICAL OPIN')
            , ('MWD','WARD')
            , ('MWISEX','WISDOM TEETH EXTRACT')
            , ('NC','NON-COVERED PERSONAL ITEMS')
            , ('NMOK','OP NM OK TO PAY')
            , ('NONPR','NON PRESCRIPTION EYE')
            , ('NOSHO','MISSED APPOINTMENT')
            , ('NRX','PRESRIPTION DRUGS')
            , ('NURS','NURSERY')
            , ('OCCUP','THERAPY')
            , ('OI','OTHER CARRIER LIABILITY – COORDINATION OF BENEFITS (COB)')
            , ('OIM','OTHER INS MEDICARE')
            , ('OIMA','OTHER INS MED ASSIGN')
            , ('OIMN','INS MED NON ASSIGNED')
            , ('OMS','OTHER MEDICAL SERVICES')
            , ('OOCB','OUT OF COUNTRY TRAVEL BENEFIT')
            , ('OOPCR','OUT OF POCKET CREDT')
            , ('OOPDL','DENTAL OUT-OF-POCKET')
            , ('OOPNP','CORRECT NON PAR OOP')
            , ('OPNEW','OUTPATIENT NEWBORN')
            , ('OPSVS','OUTPATIENT HOSPITAL SERVICES')
            , ('OPTIO','EYEGLASS OPTIONS')
            , ('OR','OPERATING/RECOVERY ROOM')
            , ('ORGAN','ORGAN ACQUISITION')
            , ('OSH','OUTPATIENT SURGERY HOSPITAL')
            , ('OSIZE','OVERSIZE LENSES')
            , ('OVECF','EXTEND CARE FACILITY')
            , ('OVPMT','OVERPAYMENTS')
            , ('OVPMY','OVERPAYMENTS')
            , ('PAB','PHYS. ADD. BENEFIT')
            , ('PAP','PAP SMEAR')
            , ('PAT','PREADMISSION TESTING')
            , ('PBEC','PART B EXCESS CHARGE')
            , ('PE','PENDED IN ERROR')
            , ('PEAP','PHYSICIAN COUNSELING')
            , ('PERX','PENDED IN ERROR - RX')
            , ('PHAR','PHARMACY')
            , ('PHC','PERSONAL HOME CARE')
            , ('PHOTO','PHOTOCHROMIC')
            , ('PHYFT','PHYSICAL FITNESS BENEFIT')
            , ('PLENSE','PLASTIC LENSES')
            , ('PMAND','WISDOM TEETH EXTRACT')
            , ('PMAX','WISDOM TEETH EXTRACT')
            , ('POD','PODIATRIST')
            , ('POLYC','POLYCARBONATE LENSES')
            , ('PR','PRIVATE ROOM')
            , ('PRE','A	PRE AUTHORIZATION')
            , ('PREAD','PRE-ADMISSION TESTING')
            , ('PREAU','PREAUTHORIZATION')
            , ('PREVNT','PREVENTIVE TESTS')
            , ('PRISMS','PRISMS (VISION BENEFIT)')
            , ('PROGR','PROGRESSIVE LENSES')
            , ('PROMO','HEALTH PROMOTIONS/WELLNESS BENEFIT REIMBURSEMENT')
            , ('PROS','PROSTHESIS')
            , ('PRX','Par pharmacy benefit')
            , ('PRXIF','Pharmacy (infertility)')
            , ('PRXIH','Pharmacy (inhalant drug)')
            , ('PRXINS','Florida CHPA products that do not have prescription drug coverage but have benefits for insulin and related supplies at a participating pharmacy')
            , ('PRXMNT','Prescription Drug Maintenance - Prescription drug deductible for maintenance medications at a participating pharmacy')
            , ('PRXSDC','Special drug copayment')
            , ('PRXSI','Injectable medication')
            , ('PRXSL','Injectable medication')
            , ('PRXINS','PRX INSULIN $ SUPPLY')
            , ('PRXMNT','PRX DRUG MAINTENANCE')
            , ('PRXNF','PRX NON FORMULARY')
            , ('PRXSDC','SPECIAL DRUG COPAYMENT')
            , ('PSYDT','PSYCHIATRIC DAY TREATMENT FACILITY')
            , ('PT','PHYSICAL THERAPY')
            , ('RAD','RADIOLOGY')
            , ('RADP','RADIOLOGY')
            , ('RADS','RADIOLOGY')
            , ('RADTH','RADIATION THERAPY')
            , ('RBOP','REIMBURSE PRIOR OOP')
            , ('RBOPP','CORRECT OOP')
            , ('RCE','ROUTINE CARE EXAM – EMPLOYEE ONLY')
            , ('RDAY','LIFETIME RESERVE DAYS 01-60')
            , ('REFLM','MICROFILM NUMBER USED FOR REFILM')
            , ('REFRC','REFRACTION CHARGE')
            , ('RESIDE','RESIDENTIAL TREATMNT')
            , ('RESP','RESPIRATORY')
            , ('REVIEW','SUBSEQUENT REVIEW')
            , ('RN','REGISTERED NURSE')
            , ('RSPT','RESPITE CARE')
            , ('RX','PHARMACY CHARGES')
            , ('RXMNT','RX DRUG MAINTENANCE')
            , ('RXNF','RX NONFORMULARY')
            , ('RXREI','REIMB RX EXCESS DEDUCTIBLE TO HDHP MBR')
            , ('SCRAT','SCRATCH RESIST COAT')
            , ('SETTLE','WORKMANS COMP SETTLE')
            , ('SHIP','SENIOR HOSP IND PLAN')
            , ('SLFDYL','SELF TREATMENT')
            , ('SN20','SKILLED NURSING 1-20 DAYS')
            , ('SN21','SKILLED NURSING DAYS 21-100')
            , ('SN22','ERROR NOT USED')
            , ('SNAIP','ADDITIONAL BENEFIT')
            , ('SNLIFE','SKILL NURSING')
            , ('SOLID','SOLID TINT')
            , ('SP','SEMIPRIVATE ROOM')
            , ('SPTH','SPEECH THERAPY')
            , ('SSO','SECOND SURGICAL OPINION')
            , ('STDCHK','ACTUAL DISABILITY PAYMENT TO EMPLOYEE')
            , ('SUBCK','SUBROGATION REIMBURSEMENT IS RECEIVED')
            , ('SUNBI','BIFOCAL PHOTO CHROMI')
            , ('SUNDG','DBL GRADIENT SUNGLAS')
            , ('SUNSG','SOLID GRADIENT SUNGL')
            , ('SUNSV','SNGL VISION PHOTO CH')
            , ('SUP','SUPPLIES')
            , ('SURCG','NEW YORK SURCHARGE')
            , ('SURCHG','SURCHARGE')
            , ('TFNMV','PHYSICIANS VISITS')
            , ('TINT','TINTING')
            , ('TRANH','HEART TRANSPLANT')
            , ('TRANK','KIDNEY TRANSPLANT')
            , ('TRANL','LIVER TRANSPLANT')
            , ('TRANM','MARROW TRANSPLANT')
            , ('TRANO','OTHER TRANSPLANT')
            , ('TRANS','HEART BENEFIT')
            , ('TRAVEL','TRAVEL EXPENSES')
            , ('TRIFO','TRIFOCAL VISION')
            , ('TRNSP','TRANSPLANT TRANSPORTATION')
            , ('TSO','THIRD SURGICAL OPINION')
            , ('UCR','ADJUSTED UCR')
            , ('ULTRA','ULTRA VIOLET COATING')
            , ('UNECF','EXTEND CARE FACILITY')
            , ('WD','WARD')
            , ('WHO','WISCONSIN HEALTH ORG')
            , ('WISEX','WISDOM TEETH EXTRACTION')
            , ('WO','WRITE OFF')
            , ('XXXXX!','OUTPT SURG FACILITY')
            , ('XXXXX#','CHRONIC INJECTION')
            , ('XXXXX$','ANESTHESIA MEDICARE')
            , ('XXXXX%','ANESTHESIA/MEDICAID')
            , ('XXXXX&','ALLERGY SERUM')
            , ('XXXXX)','DME PURCHASE')
            , ('XXXXX*','ANESTHESIA')
            , ('XXXXX+','MED RIST HCPC AMB')
            , ('XXXXX=','SUPPLIES/OMS')
            , ('XXXXX?','PROSTHESIS/ORTHOTICS')
            , ('XXXXXA','ASSISTANT SURGEON')
            , ('XXXXXB','AMBULANCE SERVICES')
            , ('XXXXXC','PHYSICIAN CALLS')
            , ('XXXXXD','HEARING THERAPY')
            , ('XXXXXE','EYE EXAM')
            , ('XXXXXF','OPEN FOR USE')
            , ('XXXXXG','ANESTHESIA')
            , ('XXXXXH','HOSPITAL VISITS')
            , ('XXXXXI','INJECTIONS')
            , ('XXXXXJ','DME')
            , ('XXXXXK','HOME HEALTH')
            , ('XXXXXL','LABORATORY')
            , ('XXXXXM','CHIROPRACTIC SERVICE')
            , ('XXXXXN','INDIV. PSYCHOTHERAPY')
            , ('XXXXXO','RAD & LAB READING')
            , ('XXXXXP','PHYSICAL THERAPY')
            , ('XXXXXQ','GROUP PSYCHOTHEARPY')
            , ('XXXXXR','RADIATION TREATMENT')
            , ('XXXXXS','SURGERY')
            , ('XXXXXT','CARDIAC THERAPY')
            , ('XXXXXU','SPEECH THERAPY')
            , ('XXXXXV','OPHTHALMOLOGY')
            , ('XXXXXW','WELL BABY CARE')
            , ('XXXXXX','X RAY')
            , ('XXXXXY','ALLERGY SHOTS')
            , ('XXXXXZ','Z CODES')
            , ('XXXXX~','TEST')
            , ('XXXXX¢','ANES MEDC RISK')
            , ('ZMATCA','INCORRECT')
            , ('ZMATDA','INCORRECT')
            , ('ZZZZZZ','Z CODES');
GO

IF OBJECT_ID('dm_lob_dim', 'U') IS NOT NULL
    DROP TABLE dm_lob_dim;
CREATE TABLE dm_lob_dim (
      code      varchar(3)
    , description   varchar(50)
);
GO

INSERT INTO dm_lob_dim (code, description)
    VALUES    ('HHP','Commercial HMO - Federal')
            , ('STE','Commercial HMO - State')
            , ('OPT','Commercial HMO/POS - Federal')
            , ('MER','Medicare HMO - Federal')
            , ('MRO','Medicare POS')
            , ('MEP','Medicare PPO')
            , ('MEF','Medicare PFFS')
            , ('ALT','ASO - Administrative Services Only')
            , ('MCD','Medicaid HMO')
            , ('MES','Medicaid Supplement')
            , ('WKC','Worker''s Compensation')
            , ('HMP','Commercial HMO - Federal (FL)')
            , ('HIP','Commercial POS (FL)')
            , ('HFC','Commercial Choice HMO (FL)')
            , ('N/A','N/A');
GO

-- create chronic conditions table (only done once, populated from SSIS/excel)

IF OBJECT_ID('dm_chrons', 'U') IS NULL
    CREATE TABLE dm_chrons (
          ICD10_Code        varchar(7)
        , ICD10_Description varchar(60)
        , Chronic_Indicator int
        , body_system       int
    )