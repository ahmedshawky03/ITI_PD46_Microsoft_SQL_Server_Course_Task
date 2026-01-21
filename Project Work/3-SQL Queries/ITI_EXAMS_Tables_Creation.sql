
-- 1. Standard Entities

create table Intake (
    Intake_id int primary key,
    Number int,
    Start_date date,
    End_date date,
    Type varchar(50)
);

create table Branch (
    Branch_id int primary key,
    Name varchar(100),
    Address varchar(255)
);

create table Instructor (
    Instructor_id int primary key,
    Name varchar(100),
    Degree varchar(100),
    Salary decimal(10,2)
);

create table Track (
    Track_id int primary key,
    Name varchar(100),
    Supervisor_id int,
    foreign key (Supervisor_id) references Instructor(Instructor_id)
);

create table Course (
    Course_id int primary key,
    Name varchar(100),
    Duration int
);

create table Topic (
    Topic_id int primary key,
    Name varchar(100),
    Course_id int,
    foreign key (Course_id) references Course(Course_id)
);

create table Student (
    Student_id int primary key,
    First_name varchar(50),
    Last_name varchar(50),
    Birth_date date
);

create table Question (
    Question_id int primary key,
    Number int,
    Text varchar(max),
    Type varchar(50)
);

create table Choice (
    Choice_id int primary key,
    Choice_text varchar(255),
    Is_correct bit,
    Question_id int,
    foreign key (Question_id) references Question(Question_id)
);

create table Exam (
    Exam_id int primary key,
    Name varchar(100),
    Duration int,
    No_of_questions int,
    Course_id int,
    foreign key (Course_id) references Course(Course_id)
);

-- 2. Relation / Hub Tables

create table Class_Offering (
    Class_offering_id int primary key,
    Intake_id int,
    Branch_id int,
    Track_id int,
    foreign key (Intake_id) references Intake(Intake_id),
    foreign key (Branch_id) references Branch(Branch_id),
    foreign key (Track_id) references Track(Track_id)
);

create table Exam_Attempt (
    Attempt_id int primary key,
    Total_score int,
    Student_id int,
    Exam_id int,
    foreign key (Student_id) references Student(Student_id),
    foreign key (Exam_id) references Exam(Exam_id)
);

-- 3. Mapping (Junction) Tables for M:N Relationships

-- Relationship: Student <--> Class Offering (Enroll)
create table Student_Enrollment (
    Student_id int,
    Class_offering_id int,
    primary key (Student_id, Class_offering_id),
    foreign key (Student_id) references Student(Student_id),
    foreign key (Class_offering_id) references Class_Offering(Class_offering_id)
);

-- Relationship: Instructor <--> Course (Teach)
create table Instructor_Course (
    Instructor_id int,
    Course_id int,
    primary key (Instructor_id, Course_id),
    foreign key (Instructor_id) references Instructor(Instructor_id),
    foreign key (Course_id) references Course(Course_id)
);

-- Relationship: Track <--> Course (Has)
create table Track_Course (
    Track_id int,
    Course_id int,
    primary key (Track_id, Course_id),
    foreign key (Track_id) references Track(Track_id),
    foreign key (Course_id) references Course(Course_id)
);

-- Relationship: Exam <--> Question (Has)
create table Exam_Question (
    Exam_id int,
    Question_id int,
    primary key (Exam_id, Question_id),
    foreign key (Exam_id) references Exam(Exam_id),
    foreign key (Question_id) references Question(Question_id)
);

-- Relationship: Exam_Attempt <--> Question (Answer)
create table Answer (
    Attempt_id int,
    Question_id int,
    Choice_id int,
    Grade int,
    primary key (Attempt_id, Question_id),
    foreign key (Attempt_id) references Exam_Attempt(Attempt_id),
    foreign key (Question_id) references Question(Question_id),
    foreign key (Choice_id) references Choice(Choice_id)
);