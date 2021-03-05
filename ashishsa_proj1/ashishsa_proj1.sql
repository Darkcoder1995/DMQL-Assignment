DROP SCHEMA IF EXISTS grp_proj1;
CREATE SCHEMA grp_proj1;
USE grp_proj1;

CREATE TABLE users(
	email_id VARCHAR(45) NOT NULL,
	display_name VARCHAR(45) NOT NULL,
	account_password VARCHAR(45) NOT NULL,
    user_type ENUM( 'Student','Professor','Staff'),
	CONSTRAINT users_pk PRIMARY KEY(email_id),
	UNIQUE(display_name)
);

CREATE TABLE department(
	department_number VARCHAR(45) NOT NULL,
    department_name VARCHAR(45),
	CONSTRAINT department_pk PRIMARY KEY(department_number),
    UNIQUE(department_name)
);

CREATE TABLE professor(
	professor_email_id VARCHAR(45) NOT NULL,
	prof_dept VARCHAR(45) NOT NULL,
	CONSTRAINT prof_fk FOREIGN KEY(professor_email_id) REFERENCES users(email_id),
	CONSTRAINT prof_fk2 FOREIGN KEY(prof_dept) REFERENCES department(department_number),
	CONSTRAINT prof_pk PRIMARY KEY(professor_email_id)
);

CREATE TABLE staff(
	staff_email_id VARCHAR(45)  NOT NULL,
	staff_dept VARCHAR(45) NOT NULL,
	CONSTRAINT staff_fk FOREIGN KEY(staff_email_id) REFERENCES users(email_id),
	CONSTRAINT staff_fk2 FOREIGN KEY(staff_dept) REFERENCES department(department_number),
	CONSTRAINT staff_pk PRIMARY KEY(staff_email_id)
);

CREATE TABLE student(
	student_email_id VARCHAR(45) NOT NULL,
    student_name VARCHAR(45),
	CONSTRAINT student_fk FOREIGN KEY(student_email_id) REFERENCES users(email_id),
	CONSTRAINT student_pk PRIMARY KEY(student_email_id)
);

CREATE TABLE program(
	program_id VARCHAR(45) NOT NULL,
	program_name VARCHAR(45) NOT NULL,
	dept_offer_prog VARCHAR(45) NOT NULL,
	CONSTRAINT program_fk FOREIGN KEY(dept_offer_prog) REFERENCES department(department_number),
	CONSTRAINT program_pk PRIMARY KEY(program_id)
);

CREATE TABLE majors(
	student_email_id VARCHAR(45) NOT NULL,
	major_dept VARCHAR(45) NOT NULL,
	CONSTRAINT major_fk FOREIGN KEY(student_email_id) REFERENCES student(student_email_id),
	CONSTRAINT major_fk2 FOREIGN KEY(major_dept) REFERENCES department(department_number),
	CONSTRAINT major_pk PRIMARY KEY(student_email_id,major_dept)
);

CREATE TABLE prog_pursue_majors(
	student_email_id VARCHAR(45) NOT NULL,
	major_dept VARCHAR(45) NOT NULL,
	program_id VARCHAR(45) NOT NULL,
	CONSTRAINT prog_pursue_maj_fk1 FOREIGN KEY(student_email_id,major_dept) REFERENCES majors(student_email_id,major_dept),
	CONSTRAINT prog_pursue_maj_fk2 FOREIGN KEY(program_id) REFERENCES program(program_id),
	CONSTRAINT prog_pursue_pk PRIMARY KEY(student_email_id,major_dept,program_id)
);

CREATE TABLE semester(
	year_offered VARCHAR(45) NOT NULL,
	season_offered VARCHAR(45) NOT NULL,
	CONSTRAINT semester_pk PRIMARY KEY(year_offered,season_offered)
);

CREATE TABLE registers(
	register_id VARCHAR(45) NOT NULL,
	student_email_id VARCHAR(45) NOT NULL,
	year_offered VARCHAR(45) NOT NULL,
	season_offered VARCHAR(45) NOT NULL,
	CONSTRAINT reg_fk1 FOREIGN KEY(student_email_id) REFERENCES student(student_email_id),
	CONSTRAINT reg_fk2 FOREIGN KEY(year_offered,season_offered) REFERENCES semester(year_offered,season_offered),
	CONSTRAINT reg_pk PRIMARY KEY(register_id),
    CONSTRAINT UNIQUE( student_email_id,year_offered,season_offered )
);

CREATE TABLE course(
	course_id VARCHAR(45) NOT NULL,
	course_name VARCHAR(45) NOT NULL,
    course_dept VARCHAR(45) NOT NULL,
    CONSTRAINT course_fk FOREIGN KEY(course_dept) REFERENCES department(department_number),
	CONSTRAINT course_pk PRIMARY KEY(course_id)
);

CREATE TABLE pre_req_course(
	course_id VARCHAR(45) NOT NULL,
	pre_req_course_id VARCHAR(45) NOT NULL,
	CONSTRAINT pre_req_fk1 FOREIGN KEY(course_id) REFERENCES course(course_id),
	CONSTRAINT pre_req_fk2 FOREIGN KEY(pre_req_course_id) REFERENCES course(course_id),
    CONSTRAINT pre_req_pk PRIMARY KEY(course_id,pre_req_course_id)
);

CREATE TABLE instructor(

	instructor_email_id VARCHAR(45) NOT NULL,
    CONSTRAINT inst_fk FOREIGN KEY(instructor_email_id) REFERENCES professor(professor_email_id),
    CONSTRAINT inst_pk PRIMARY KEY(instructor_email_id)

);

CREATE TABLE courses_available(
	course_id VARCHAR(45) NOT NULL,
    year_offered VARCHAR(45) NOT NULL,
	season_offered VARCHAR(45) NOT NULL,
	capacity int NOT NULL,
    session_id VARCHAR(45),
	CONSTRAINT open_fk1 FOREIGN KEY(course_id) REFERENCES course(course_id),
	CONSTRAINT open_fk3 FOREIGN KEY(year_offered,season_offered) REFERENCES semester(year_offered,season_offered),
	CONSTRAINT open_pk PRIMARY KEY(course_id,year_offered,season_offered,session_id)
);

CREATE TABLE enroll(
	register_id VARCHAR(45) NOT NULL,
	course_id VARCHAR(45) NOT NULL,
	year_offered VARCHAR(45) NOT NULL,
	season_offered VARCHAR(45) NOT NULL,
    session_id VARCHAR(45),
    completed ENUM('Y','N'),
	subject_passed ENUM('Y','N') NOT NULL,
    subject_grade ENUM( 'A','B','C','D','F'),
	CONSTRAINT register_fk FOREIGN KEY(register_id) REFERENCES registers(register_id),
	CONSTRAINT enroll_fk FOREIGN KEY(course_id,year_offered,season_offered,session_id) 
		REFERENCES courses_available(course_id,year_offered,season_offered,session_id),
	CONSTRAINT enroll_pk PRIMARY KEY(register_id,course_id,year_offered,season_offered,session_id)
);

CREATE TABLE instructs(

	instructor_email_id VARCHAR(45) NOT NULL,
    course_id VARCHAR(45) NOT NULL,
	year_offered VARCHAR(45) NOT NULL,
    season_offered VARCHAR(45) NOT NULL,
    session_id VARCHAR(45),
    CONSTRAINT inst_fk1 FOREIGN KEY(instructor_email_id) REFERENCES instructor(instructor_email_id),
    CONSTRAINT inst_fk2 FOREIGN KEY(course_id,year_offered,season_offered,session_id) 
		REFERENCES courses_available(course_id,year_offered,season_offered,session_id),
    CONSTRAINT inst_pk PRIMARY KEY(instructor_email_id,course_id,year_offered,season_offered,session_id)

);

CREATE TABLE feedback(
	feedback VARCHAR(45) NOT NULL,
	instructor_email_id VARCHAR(45) NOT NULL,
	course_id VARCHAR(45) NOT NULL,
	year_offered VARCHAR(45) NOT NULL,
	season_offered VARCHAR(45) NOT NULL,
	session_id VARCHAR(45) NOT NULL,
    register_id VARCHAR(45) NOT NULL,
	CONSTRAINT feedback_fk1 FOREIGN KEY(instructor_email_id,course_id,year_offered,season_offered,session_id) 
		REFERENCES instructs(instructor_email_id,course_id,year_offered,season_offered,session_id),
	CONSTRAINT feedback_fk2 FOREIGN KEY(register_id) 
		REFERENCES enroll(register_id),
	CONSTRAINT feedback_pk PRIMARY KEY(instructor_email_id,course_id,year_offered,season_offered,session_id,register_id)
);

CREATE TABLE ta(
	student_email_id VARCHAR(45) NOT NULL,
    course_id VARCHAR(45) NOT NULL,
    year_offered VARCHAR(45) NOT NULL,
	season_offered VARCHAR(45) NOT NULL,
    session_id VARCHAR(45),
    CONSTRAINT ta_fk1 FOREIGN KEY(student_email_id) 
		REFERENCES student(student_email_id),
	CONSTRAINT ta_fk2 FOREIGN KEY(course_id,year_offered,season_offered,session_id) 
		REFERENCES courses_available(course_id,year_offered,season_offered,session_id),
	CONSTRAINT ta_pk PRIMARY KEY(student_email_id,course_id,year_offered,season_offered,session_id)

);

CREATE TABLE exam(
	exam_id VARCHAR(45) NOT NULL,
	course_id VARCHAR(45) NOT NULL,
	session_id VARCHAR(45) NOT NULL,
	year_offered VARCHAR(45) NOT NULL,
	season_offered VARCHAR(45) NOT NULL,
	CONSTRAINT hasexam_fk FOREIGN KEY(course_id,year_offered,season_offered,session_id) 
		REFERENCES courses_available(course_id,year_offered,season_offered,session_id),
	PRIMARY KEY(exam_id)
);

CREATE TABLE student_takes_exam(
	exam_id VARCHAR(45) NOT NULL,
	register_id VARCHAR(45) NOT NULL,
	course_id VARCHAR(45) NOT NULL,
	year_offered VARCHAR(45) NOT NULL,
	season_offered VARCHAR(45) NOT NULL,
    session_id VARCHAR(45),
	final_grade VARCHAR(45) NOT NULL,
	CONSTRAINT exam_fk FOREIGN KEY(exam_id) REFERENCES exam(exam_id),
	CONSTRAINT exam_fk2 FOREIGN KEY(register_id,course_id,year_offered,season_offered,session_id) 
		REFERENCES enroll(register_id,course_id,year_offered,season_offered,session_id),
	CONSTRAINT exam_pk PRIMARY KEY(exam_id,register_id,course_id,year_offered,season_offered,session_id)
);

CREATE TABLE problems(
	problem_id VARCHAR(45) NOT NULL,
	exam_id VARCHAR(45) NOT NULL,
	scores VARCHAR(45) NOT NULL,
	CONSTRAINT problems_fk FOREIGN KEY(exam_id) 
		REFERENCES exam(exam_id),
	CONSTRAINT problem_pk PRIMARY KEY(problem_id)
);

CREATE TABLE result(
	problem_id VARCHAR(45) NOT NULL,
	exam_id VARCHAR(45) NOT NULL,
	register_id VARCHAR(45) NOT NULL,
	course_id VARCHAR(45) NOT NULL,
	year_offered VARCHAR(45) NOT NULL,
	season_offered VARCHAR(45) NOT NULL,
    session_id VARCHAR(45),
    scores int,
    CONSTRAINT result_fk1 FOREIGN KEY(problem_id) 
		REFERENCES problems(problem_id),
	CONSTRAINT result_fk2 FOREIGN KEY(exam_id,register_id,course_id,year_offered,season_offered,session_id) 
		REFERENCES student_takes_exam(exam_id,register_id,course_id,year_offered,season_offered,session_id),
	CONSTRAINT result_pk PRIMARY KEY(problem_id,exam_id,register_id,course_id,year_offered,season_offered,session_id)
);

CREATE TABLE book(
	ISBN VARCHAR(45) NOT NULL,
	title VARCHAR(45) NOT NULL,
	pages int NOT NULL,
	publication_date DATE NOT NULL,
	CONSTRAINT book_pk PRIMARY KEY(ISBN)
);

CREATE TABLE author(
	author_id VARCHAR(45) NOT NULL,
    author_name VARCHAR(45) NOT NULL,
	CONSTRAINT auth_pk PRIMARY KEY(author_id)
);

CREATE TABLE library(
	university_id VARCHAR(45) NOT NULL,
	PRIMARY KEY (university_id)
);

CREATE TABLE physical_library(
	library_id VARCHAR(45) NOT NULL,
    university_id VARCHAR(45) NOT NULL,
	library_location VARCHAR(45) NOT NULL,
	FOREIGN KEY(university_id) REFERENCES library(university_id),
	CONSTRAINT physical_library_pk PRIMARY KEY(library_id)
);

CREATE TABLE copies(
	ISBN VARCHAR(45) NOT NULL,
	date_of_purchase DATE,
	book_id VARCHAR(45) NOT NULL,
	price int,
    library_id VARCHAR(45) NOT NULL,
    CONSTRAINT copies_fk1 FOREIGN KEY(library_id) REFERENCES physical_library(library_id),
	CONSTRAINT copies_fk2 FOREIGN KEY(ISBN) REFERENCES book(ISBN),
	CONSTRAINT copies_pk PRIMARY KEY(book_id)
);

CREATE TABLE writes(
	author_id VARCHAR(45) NOT NULL,
	ISBN VARCHAR(45) NOT NULL,
	CONSTRAINT auth_fk FOREIGN KEY(author_id) REFERENCES author(author_id),
	CONSTRAINT auth_fk2 FOREIGN KEY(ISBN) REFERENCES book(ISBN),
    CONSTRAINT auth_pk PRIMARY KEY(author_id,ISBN)
);


CREATE TABLE borrow(
	book_id VARCHAR(45) NOT NULL,
	borrower_email_id VARCHAR(45) NOT NULL,
    issue_date DATE NOT NULL,
	return_date DATE NOT NULL,
    extended_date DATE,
	extension_requested ENUM('Y','N') NOT NULL,
	returned ENUM('Y','N') NOT NULL,
	CONSTRAINT borrow_fk1 FOREIGN KEY(book_id) 
		REFERENCES copies(book_id),
	CONSTRAINT borrow_fk2 FOREIGN KEY(borrower_email_id) REFERENCES users(email_id),
    CONSTRAINT borrow_pk PRIMARY KEY(book_id,borrower_email_id)
);