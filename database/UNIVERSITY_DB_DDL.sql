CREATE TABLE LOCATION
(loc_id NUMERIC(6),
bldg_code VARCHAR(10),
room VARCHAR(6),
capacity NUMERIC(5), 
CONSTRAINT location_loc_id_pk PRIMARY KEY (loc_id));

CREATE TABLE faculty
(f_id NUMERIC(6),
f_last VARCHAR(30),
f_first VARCHAR(30),
f_mi CHAR(1),
loc_id NUMERIC(5),
f_phone VARCHAR(10),
f_rank VARCHAR(8),
f_pin NUMERIC(4),
f_image BLOB, 
CONSTRAINT faculty_f_id_pk PRIMARY KEY(f_id),
CONSTRAINT faculty_loc_id_fk FOREIGN KEY (loc_id) REFERENCES location(loc_id));

CREATE TABLE student
(s_id NUMERIC(6),
s_last VARCHAR(30),
s_first VARCHAR(30),
s_mi CHAR(1),
s_add VARCHAR(25),
s_city VARCHAR(20),
s_state CHAR(2),
s_zip VARCHAR(9),
s_phone VARCHAR(10),
s_class CHAR(2),
s_dob DATE,
s_pin NUMERIC(4),
f_id NUMERIC(6),
CONSTRAINT student_s_id_pk PRIMARY KEY (s_id),
CONSTRAINT student_f_id_fk FOREIGN KEY (f_id) REFERENCES faculty(f_id));

CREATE TABLE TERM
(term_id NUMERIC(6),
term_desc VARCHAR(20),
status VARCHAR(20),
CONSTRAINT term_term_id_pk PRIMARY KEY (term_id),
CONSTRAINT term_status_cc CHECK ((status = 'OPEN') OR (status = 'CLOSED')));

CREATE TABLE COURSE
(course_id NUMERIC(6),
call_id VARCHAR(10),
course_name VARCHAR(25),
credits NUMERIC(2),
CONSTRAINT course_course_id_pk PRIMARY KEY(course_id));

CREATE TABLE COURSE_SECTION
(c_sec_id NUMERIC(6),
course_id NUMERIC(6)  NOT NULL,
term_id NUMERIC(6)  NOT NULL,
sec_num NUMERIC(2)  NOT NULL,
f_id NUMERIC(5),
cs_day VARCHAR(10),
cs_time TIME,
loc_id NUMERIC(6),
max_enrl NUMERIC(4)  NOT NULL,
CONSTRAINT course_section_csec_id_pk PRIMARY KEY (c_sec_id),
CONSTRAINT course_section_cid_fk FOREIGN KEY (course_id) REFERENCES course(course_id), 	
CONSTRAINT course_section_loc_id_fk FOREIGN KEY (loc_id) REFERENCES location(loc_id),
CONSTRAINT course_section_termid_fk FOREIGN KEY (term_id) REFERENCES term(term_id),
CONSTRAINT course_section_fid_fk FOREIGN KEY (f_id) REFERENCES faculty(f_id));


CREATE TABLE ENROLLMENT
(s_id NUMERIC(6),
c_sec_id NUMERIC(6),
grade CHAR(1),
CONSTRAINT enrollment_pk PRIMARY KEY (s_id, c_sec_id),
CONSTRAINT enrollment_sid_fk FOREIGN KEY (s_id) REFERENCES student(s_id),
CONSTRAINT enrollment_csecid_fk FOREIGN KEY (c_sec_id) REFERENCES course_section (c_sec_id),
CONSTRAINT enrollment_grade_cc
    CHECK ((grade = 'A') OR (grade = 'B') 
    OR (grade = 'C') OR (grade = 'D') OR (grade = 'F') OR (grade = 'N')));



-- inserting into LOCATION table
INSERT INTO location VALUES
(45, 'CR', '101', 150);

INSERT INTO location VALUES
(46, 'CR', '202', 40);

INSERT INTO location VALUES
(47, 'CR', '103', 35);

INSERT INTO location VALUES
(48, 'CR', '105', 35);

INSERT INTO location VALUES
(49, 'BUS', '105', 42);

INSERT INTO location VALUES
(50, 'BUS', '404', 35);

INSERT INTO location VALUES
(51, 'BUS', '421', 35);

INSERT INTO location VALUES
(52, 'BUS', '211', 55);

INSERT INTO location VALUES
(53, 'BUS', '424', 1);

INSERT INTO location VALUES
(54, 'BUS', '402', 1);

INSERT INTO location VALUES
(55, 'BUS', '433', 1);

INSERT INTO location VALUES
(56, 'LIB', '217', 2);

INSERT INTO location VALUES
(57, 'LIB', '222', 1);

-- inserting records into FACULTY
INSERT INTO faculty VALUES
(1, 'Cox', 'Kim', 'J', 53, '7155551234', 'ASSO', 1181, NULL);

INSERT INTO faculty VALUES
(2, 'Blanchard', 'John', 'R', 54, '7155559087', 'FULL', 1075, NULL);

INSERT INTO faculty VALUES
(3, 'Williams', 'Jerry', 'F', 56, '7155555412', 'ASST', 8531, NULL);

INSERT INTO faculty VALUES
(4, 'Sheng', 'Laura', 'M', 55, '7155556409', 'INST', 1690, NULL);

INSERT INTO faculty VALUES
(5, 'Brown', 'Philip', 'E', 57, '7155556082', 'ASSO', 9899, NULL);

-- inserting records into STUDENT
INSERT INTO student VALUES
(100, 'Miller', 'Sarah', 'M', '144 Windridge Blvd.', 'Eau Claire', 
'WI', '54703', '7155559876', 'SR', '1982-07-14', 8891, 1);

INSERT INTO student VALUES
(101, 'Umato', 'Brian', 'D', '454 St. John''s Street', 'Eau Claire', 
'WI', '54702', '7155552345', 'SR', '1982-08-19', 1230, 1);

INSERT INTO student VALUES
(102, 'Black', 'Daniel', NULL, '8921 Circle Drive', 'Bloomer', 
'WI', '54715', '7155553907', 'JR', '1979-10-10', 1613, 1);

INSERT INTO student VALUES
(103, 'Mobley', 'Amanda', 'J', '1716 Summit St.', 'Eau Claire', 
'WI', '54703', '7155556902', 'SO', '1981-09-24', 1841, 2);

INSERT INTO student VALUES
(104, 'Sanchez', 'Ruben', 'R', '1780 Samantha Court', 'Eau Claire', 
'WI', '54701', '7155558899', 'SO', '1981-11-20', 4420, 4);

INSERT INTO student VALUES
(105, 'Connoly', 'Michael', 'S', '1818 Silver Street', 'Elk Mound', 
'WI', '54712', '7155554944', 'FR', '1983-12-4', 9188, 3);

-- inserting records into TERM
INSERT INTO term VALUES
(1, 'Fall 2002', 'CLOSED');

INSERT INTO term VALUES
(2, 'Spring 2003', 'CLOSED');

INSERT INTO term VALUES
(3, 'Summer 2003', 'CLOSED');

INSERT INTO term VALUES
(4, 'Fall 2003', 'CLOSED');

INSERT INTO term VALUES
(5, 'Spring 2004', 'CLOSED');

INSERT INTO term VALUES
(6, 'Summer 2004', 'OPEN');

-- inserting records into COURSE
INSERT INTO course VALUES
(1, 'MIS 101', 'Intro. to Info. Systems', 3);

INSERT INTO course VALUES
(2, 'MIS 301', 'Systems Analysis', 3);

INSERT INTO course VALUES
(3, 'MIS 441', 'Database Management', 3);

INSERT INTO course VALUES
(4, 'CS 155', 'Programming in C++', 3);

INSERT INTO course VALUES
(5, 'MIS 451', 'Web-Based Systems', 3);

-- inserting records into COURSE_SECTION
INSERT INTO course_section VALUES
(1000, 1, 4, 1, 2, 'MWF', '10:00:00', 45, 140);

INSERT INTO course_section VALUES
(1001, 1, 4, 2, 3, 'TTH', '09:30:00', 51, 35);

INSERT INTO course_section VALUES
(1002, 1, 4, 3, 3, 'MWF', '08:00:00', 46, 35);

INSERT INTO course_section VALUES
(1003, 2, 4, 1, 4, 'TTH', '11:00:00', 50, 35);

INSERT INTO course_section VALUES
(1004, 2, 5, 2, 4, 'TTH', '14:00:00', 50, 35);

INSERT INTO course_section VALUES
(1005, 3, 5, 1, 1, 'MWF', '09:00:00', 49, 30);

INSERT INTO course_section VALUES
(1006, 3, 5, 2, 1, 'MWF', '10:00:00', 49, 30);

INSERT INTO course_section VALUES
(1007, 4, 5, 1, 5, 'TTH','08:00:00', 47, 35);

INSERT INTO course_section VALUES
(1008, 5, 5, 1, 2, 'MWF', '14:00:00', 49, 35);

INSERT INTO course_section VALUES
(1009, 5, 5, 2, 2, 'MWF', '15:00:00', 49, 35);

INSERT INTO course_section VALUES
(1010, 1, 6, 1, 1, 'M-F', '08:00:00', 45, 50);

INSERT INTO course_section VALUES
(1011, 2, 6, 1, 2, 'M-F', '08:00:00',50, 35);

INSERT INTO course_section VALUES
(1012, 3, 6, 1, 3, 'M-F', '09:00:00', 49, 35);

-- inserting records into ENROLLMENT
INSERT INTO enrollment VALUES
(100, 1000, 'A');

INSERT INTO enrollment VALUES
(100, 1003, 'A');

INSERT INTO enrollment VALUES
(100, 1005, 'B');

INSERT INTO enrollment VALUES
(100, 1008, 'B');

INSERT INTO enrollment VALUES
(101, 1000, 'C');

INSERT INTO enrollment VALUES
(101, 1004, 'B');

INSERT INTO enrollment VALUES
(101, 1005, 'A');

INSERT INTO enrollment VALUES
(101, 1008, 'B');

INSERT INTO enrollment VALUES
(102, 1000, 'C');

INSERT INTO enrollment VALUES
(102, 1011, NULL);

INSERT INTO enrollment VALUES
(102, 1012, NULL);

INSERT INTO enrollment VALUES
(103, 1010, NULL);

INSERT INTO enrollment VALUES
(103, 1011, NULL);

INSERT INTO enrollment VALUES
(104, 1000, 'B');

INSERT INTO enrollment VALUES
(104, 1004, 'C');

INSERT INTO enrollment VALUES
(104, 1008, 'C');

INSERT INTO enrollment VALUES
(104, 1012, NULL);

INSERT INTO enrollment VALUES
(104, 1010, NULL);

INSERT INTO enrollment VALUES
(105, 1010, NULL);

INSERT INTO enrollment VALUES
(105, 1011, NULL);

COMMIT;
