USE grp_proj1;
#WE INSERT THE VALUES OF THE THE SEMESTER THE COURSE IS OFFERED AND THE YEAR THE COURSE IS OFFERED
INSERT INTO semester(year_offered,season_offered) VALUES('2020','FALL');
INSERT INTO semester(year_offered,season_offered) VALUES('2019','SPRING');
#WE INSERT THE VALUES OF DEPARTMENT NUMBER AND DEPARTMENT NAME IN THE DEPARTMENTS TABLE
INSERT INTO department(department_number,department_name) VALUES('1','COMPUTER SCIENCE');
#WE INSERT THE COURSE ID AND COURSE NAME AND THE DEPARTMENT NAME IN THE COURSE TABLE
INSERT INTO course(course_id,course_name,course_dept) VALUES('CSE360','INTRO TO DATA MINING QUERY LANGUAGE','1');
#WE INSERT THE COURSE ID AND COURSE NAME AND THE DEPARTMENT NAME IN THE COURSE TABLE
INSERT INTO course(course_id,course_name,course_dept) VALUES('CSE560','ADVANCED DATA MINING QUERY LANGUAGE','1');
#WE INSERT PRE REQUISITE COURSE IN THE PRE REQUISITE COURSE TABLE
INSERT INTO pre_req_course(course_id,pre_req_course_id) VALUES('CSE560','CSE360');
#WE NOW ADD THE COURSES AVAILABLE
INSERT INTO courses_available(course_id,year_offered,season_offered,capacity,session_id) VALUES('CSE360','2019','SPRING','150','SESSION1');
INSERT INTO courses_available(course_id,year_offered,season_offered,capacity,session_id) VALUES('CSE560','2020','FALL','200','SESSION2');
#INSERT USER
INSERT INTO users(email_id,display_name,account_password,user_type) VALUES('bartsam@buffalo.edu','BART101','USER101','Student');
#NOW WE INSERT THE USER VALUE INTO THE STUDENT TABLE
INSERT INTO student(student_email_id,student_name) VALUES ('bartsam@buffalo.edu','BARTELOMEO SAM');
#WE INSERT VALUES INTO THE REGISTERS TABLE
INSERT INTO registers(register_id,student_email_id,year_offered,season_offered) VALUES('20BCE001','bartsam@buffalo.edu','2020','FALL');
#WE TRY TO REGISTER AN UN-REGISTERED STUDENT INTO THE ENROLL TABLE
INSERT INTO enroll(register_id,course_id,year_offered,season_offered,session_id,completed,subject_passed,subject_grade) VALUES('20BCE001','CSE360','2019','SPRING','SESSION1','Y','Y','A');
INSERT INTO enroll(register_id,course_id,year_offered,season_offered,session_id,completed,subject_passed,subject_grade) VALUES('20BCE001','CSE560','2020','FALL','SESSION2','N','N','A');
#DELETE THE USER FROM THE USER DATA BASE
SELECT * FROM users;
DELETE FROM users WHERE display_name='BART101';
