create database Nikhil_Analytics

Use Nikhil_Analytics

CREATE TABLE STUDENT_INFO (
    STUDENT_ID VARCHAR(10) CONSTRAINT PK_STUDENT_INFO PRIMARY KEY,
    NAME VARCHAR(20) NOT NULL,
    ADDRESS VARCHAR(90) NOT NULL,
    PHONE_NO CHAR(10) NOT NULL,
    EMAIL_ID VARCHAR(30) NOT NULL,
    QUALIFICATION1 VARCHAR(50),
    QUALIFICATION2 VARCHAR(50),
    EXPERIENCE DECIMAL(3,1),
    COMPANY_NAME VARCHAR(50),
    COURSE_OPTED1 VARCHAR(50) NOT NULL,
    COURSE_OPTED2 VARCHAR(50),
    COURSE_OPTED3 VARCHAR(50),
    ADMISSION_DATE DATE NOT NULL,
    EXPECTED_END_DATE DATE
)

ALTER TABLE STUDENT_INFO
ADD CONSTRAINT CHK_COURSE_OPTED1
CHECK (COURSE_OPTED1 IN ('REPORTING ANALYSIS POWER PACK',
                        'BUSINESS ANALYTICS POWER PACK',
                        'DATA ANALYTICS POWER PACK',
                        'DATA SCIENCE MODELLING & MACHINE LEARNING'))


ALTER TABLE STUDENT_INFO
ADD CONSTRAINT CHK_COURSE_OPTED2
CHECK (COURSE_OPTED2 IN ('REPORTING ANALYSIS POWER PACK',
                        'BUSINESS ANALYTICS POWER PACK',
                        'DATA ANALYTICS POWER PACK',
                        'DATA SCIENCE MODELLING & MACHINE LEARNING') OR COURSE_OPTED2 IS NULL)

ALTER TABLE STUDENT_INFO
ADD CONSTRAINT CHK_COURSE_OPTED3
CHECK (COURSE_OPTED3 IN ('REPORTING ANALYSIS POWER PACK',
                        'BUSINESS ANALYTICS POWER PACK',
                        'DATA ANALYTICS POWER PACK',
                        'DATA SCIENCE MODELLING & MACHINE LEARNING') OR COURSE_OPTED3 IS NULL)

CREATE TRIGGER TRG_STUDENT_ID
ON STUDENT_INFO
INSTEAD OF INSERT
AS
BEGIN
    SET NOCOUNT ON

    INSERT INTO STUDENT_INFO (STUDENT_ID, NAME, ADDRESS, PHONE_NO, EMAIL_ID, QUALIFICATION1, QUALIFICATION2, EXPERIENCE, COMPANY_NAME, COURSE_OPTED1, COURSE_OPTED2, COURSE_OPTED3, ADMISSION_DATE, EXPECTED_END_DATE)
    SELECT 
        'STD_' + CONVERT(VARCHAR, YEAR(ADMISSION_DATE)) + '_' + RIGHT('00' + CONVERT(VARCHAR, ROW_NUMBER() OVER (ORDER BY ADMISSION_DATE)), 2),
        NAME, ADDRESS, PHONE_NO, EMAIL_ID, QUALIFICATION1, QUALIFICATION2, EXPERIENCE, COMPANY_NAME, COURSE_OPTED1, COURSE_OPTED2, COURSE_OPTED3, ADMISSION_DATE,
        CASE
            WHEN COURSE_OPTED1 = 'REPORTING ANALYSIS POWER PACK' THEN DATEADD(MONTH, 3, ADMISSION_DATE)
            WHEN COURSE_OPTED1 = 'BUSINESS ANALYTICS POWER PACK' THEN DATEADD(MONTH, 6, ADMISSION_DATE)
            WHEN COURSE_OPTED1 = 'DATA ANALYTICS POWER PACK' THEN DATEADD(MONTH, 7, ADMISSION_DATE)
            WHEN COURSE_OPTED1 = 'DATA SCIENCE MODELLING & MACHINE LEARNING' THEN DATEADD(MONTH, 8, ADMISSION_DATE)
            ELSE NULL
        END
    FROM INSERTED
END

--2
-- Create R_marks_info table
CREATE TABLE R_marks_info (
    Student_ID VARCHAR(10) NOT NULL,
    Class_start_Date DATE,
    Class_End_Date DATE,
    Faculty VARCHAR(50) NOT NULL,
    Test_1 DECIMAL(5,2),
    Test_2 DECIMAL(5,2),
    Test_3 DECIMAL(5,2),
    Retest1 DECIMAL(5,2),
    Retest2 DECIMAL(5,2),
    Retest3 DECIMAL(5,2),
    CONSTRAINT PK_R_marks_info PRIMARY KEY (Student_ID),
    CONSTRAINT FK_R_marks_info_Student_ID FOREIGN KEY (Student_ID) REFERENCES STUDENT_INFO (STUDENT_ID)
)

--3
-- Create SAS_marks_info table
CREATE TABLE SAS_marks_info (
    Student_ID VARCHAR(10) NOT NULL,
    Class_start_Date DATE,
    Class_End_Date DATE,
    Faculty VARCHAR(50) NOT NULL,
    [MT-1] DECIMAL(5,2),
    [MT-2] DECIMAL(5,2),
    Data_step_test DECIMAL(5,2),
    [MT-3] DECIMAL(5,2),
    Proc_Test DECIMAL(5,2),
    [Base SAS Test] DECIMAL(5,2),
    Retest1 DECIMAL(5,2),
    Retest2 DECIMAL(5,2),
    Retest3 DECIMAL(5,2),
    CONSTRAINT PK_SAS_marks_info PRIMARY KEY (Student_ID),
    CONSTRAINT FK_SAS_marks_info_Student_ID FOREIGN KEY (Student_ID) REFERENCES STUDENT_INFO(STUDENT_ID)
)

--4
-- Create SQL_marks_info table
CREATE TABLE SQL_marks_info (
    Student_ID VARCHAR(10) NOT NULL,
    Class_start_Date DATE,
    Class_End_Date DATE,
    Faculty VARCHAR(50) NOT NULL,
    SQL_test1 DECIMAL(5,2),
    SQL_test2 DECIMAL(5,2),
    Retest1 DECIMAL(5,2),
    Retest2 DECIMAL(5,2),
    CONSTRAINT PK_SQL_marks_info PRIMARY KEY (Student_ID),
    CONSTRAINT FK_SQL_marks_info_Student_ID FOREIGN KEY (Student_ID) REFERENCES STUDENT_INFO(STUDENT_ID)
)

--5
-- Create EXCEL_marks_info table
CREATE TABLE EXCEL_marks_info (
    Student_ID VARCHAR(10) NOT NULL,
    Class_start_Date DATE,
    Class_End_Date DATE,
    Faculty VARCHAR(50) NOT NULL,
    Basic_excel_test DECIMAL(5,2),
    MT1 DECIMAL(5,2),
    Excel_test1 DECIMAL(5,2),
    Retest DECIMAL(5,2),
    CONSTRAINT PK_EXCEL_marks_info PRIMARY KEY (Student_ID),
    CONSTRAINT FK_EXCEL_marks_info_Student_ID FOREIGN KEY (Student_ID) REFERENCES STUDENT_INFO(STUDENT_ID)
)

--6
-- Create VBA_marks_info table
CREATE TABLE VBA_marks_info (
    Student_ID VARCHAR(10) NOT NULL,
    Class_start_Date DATE,
    Class_End_Date DATE,
    Faculty VARCHAR(50) NOT NULL,
    Function_excel_Test DECIMAL(5,2),
    Function_vba_test DECIMAL(5,2),
    Final_test DECIMAL(5,2),
    Retest1 DECIMAL(5,2),
    CONSTRAINT PK_VBA_marks_info PRIMARY KEY (Student_ID),
    CONSTRAINT FK_VBA_marks_info_Student_ID FOREIGN KEY (Student_ID) REFERENCES STUDENT_INFO(STUDENT_ID)
)

--7
-- Create TABLEAU_marks_info table
CREATE TABLE TABLEAU_marks_info (
    Student_ID VARCHAR(10) NOT NULL,
    Class_start_Date DATE,
    Class_End_Date DATE,
    Faculty VARCHAR(50) NOT NULL,
    MT1 DECIMAL(5,2),
    Test1 DECIMAL(5,2),
    Retest1 DECIMAL(5,2),
    CONSTRAINT PK_TABLEAU_marks_info PRIMARY KEY (Student_ID),
    CONSTRAINT FK_TABLEAU_marks_info_Student_ID FOREIGN KEY (Student_ID) REFERENCES STUDENT_INFO(STUDENT_ID)
)

--8
-- Create PYTHON_marks_info table
CREATE TABLE PYTHON_marks_info (
    Student_ID VARCHAR(10) NOT NULL,
    Class_start_Date DATE,
    Class_End_Date DATE,
    Faculty VARCHAR(50) NOT NULL,
    Test1 DECIMAL(5,2),
    Test2 DECIMAL(5,2),
    Retest1 DECIMAL(5,2),
    Retest2 DECIMAL(5,2),
    CONSTRAINT PK_PYTHON_marks_info PRIMARY KEY (Student_ID),
    CONSTRAINT FK_PYTHON_marks_info_Student_ID FOREIGN KEY (Student_ID) REFERENCES STUDENT_INFO(STUDENT_ID)
)

--9
-- Create ML_marks_info table
CREATE TABLE ML_marks_info (
    Student_ID VARCHAR(10) NOT NULL,
    Class_start_Date DATE,
    Class_End_Date DATE,
    Faculty VARCHAR(50) NOT NULL,
    Test1 DECIMAL(5,2),
    Test2 DECIMAL(5,2),
    Retest DECIMAL(5,2),
    CONSTRAINT PK_ML_marks_info PRIMARY KEY (Student_ID),
    CONSTRAINT FK_ML_marks_info_Student_ID FOREIGN KEY (Student_ID) REFERENCES STUDENT_INFO(STUDENT_ID)
)

--10
-- Create ASAS_marks_info table
CREATE TABLE ASAS_marks_info (
    Student_ID VARCHAR(10) NOT NULL,
    Class_start_Date DATE,
    Class_End_Date DATE,
    Faculty VARCHAR(50) NOT NULL,
    MT1 DECIMAL(5,2),
    MT2 DECIMAL(5,2),
    Final_test DECIMAL(5,2),
    Retest DECIMAL(5,2),
    CONSTRAINT PK_ASAS_marks_info PRIMARY KEY (Student_ID),
    CONSTRAINT FK_ASAS_marks_info_Student_ID FOREIGN KEY (Student_ID) REFERENCES STUDENT_INFO(STUDENT_ID)
)

--11
-- Create FULL_LENGTH_marks_info table
CREATE TABLE FULL_LENGTH_marks_info (
    Student_ID VARCHAR(10) NOT NULL,
    Class_start_Date DATE,
    Class_End_Date DATE,
    Faculty VARCHAR(50) NOT NULL,
    R_test DECIMAL(5,2),
    SAS_test DECIMAL(5,2),
    SQL_test DECIMAL(5,2),
    Excel_test DECIMAL(5,2),
    VBA_test DECIMAL(5,2),
    Python_test DECIMAL(5,2),
    Tableau_test DECIMAL(5,2),
    CONSTRAINT PK_FULL_LENGTH_marks_info PRIMARY KEY (Student_ID),
    CONSTRAINT FK_FULL_LENGTH_marks_info_Student_ID FOREIGN KEY (Student_ID) REFERENCES STUDENT_INFO(STUDENT_ID)
)

--12
-- Create Placement_Activity table
CREATE TABLE Placement_Activity (
    Student_ID VARCHAR(10) NOT NULL,
    Mock_interview1 VARCHAR(50),
    Mock_interview2 VARCHAR(50),
    Mock_interview3 VARCHAR(50),
    Resume_Finalised VARCHAR(50),
    Profile_Building VARCHAR(50),
    Certificate_Issued CHAR(3) CHECK (Certificate_Issued IN ('YES', 'NO')),
    Actual_course_enddate DATE,
    CONSTRAINT PK_Placement_Activity PRIMARY KEY (Student_ID),
    CONSTRAINT FK_Placement_Activity_Student_ID FOREIGN KEY (Student_ID) REFERENCES STUDENT_INFO(STUDENT_ID)
)










