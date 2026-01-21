--1- intake table
create procedure sp_selectIntake
as
begin
    set nocount on; -- better performance with select
    select * from Intake;
end;
go

create procedure sp_deleteIntake(@intake_id int)
as
begin
    set nocount on;
    delete from Intake where intake_id = @intake_id;
end;
go

create procedure sp_updateIntake(
    @intake_id int,
    @num int = null,
    @start_date date = null,
    @end_date date = null,
    @type varchar(100) = null
)
as
begin
    set nocount on;
    update Intake
    set Number = coalesce(@num, Number),
        start_date = coalesce(@start_date, start_date),
        end_date = coalesce(@end_date, end_date),
        type = coalesce(@type, type)
    where intake_id = @intake_id;
end;
go

create procedure sp_insertIntake(
    @intake_id int,
    @num int = null,
    @start_date date = null,
    @end_date date = null,
    @type varchar(100) = null
)
as
begin
    set nocount on;
    if @intake_id is null
        throw 50000, 'intake_id is required', 1;
    if @num is null
        throw 50001, 'num is required', 1;
    begin try
        insert into Intake(intake_id, Number, start_date, end_date, type)
        values(@intake_id, @num, @start_date, @end_date, @type);
    end try
    begin catch
        throw;
    end catch
end;
go

--2- branch table
create procedure sp_selectBranch
as
begin
    set nocount on;
    select * from Branch;
end;
go

create procedure sp_deleteBranch(@branch_id int)
as
begin
    set nocount on;
    delete from Branch where branch_id = @branch_id;
end;
go

create procedure sp_updateBranch(
    @branch_id int,
    @name varchar(200) = null,
    @address varchar(500) = null
)
as
begin
    set nocount on;
    update Branch
    set name = coalesce(@name, name),
        address = coalesce(@address, address)
    where branch_id = @branch_id;
end;
go

create procedure sp_insertBranch(
    @branch_id int,
    @name varchar(200) = null,
    @address varchar(500) = null
)
as
begin
    set nocount on;
    if @branch_id is null
        throw 50010, 'branch_id is required', 1;
    if @name is null
        throw 50011, 'name is required', 1;
    begin try
        insert into Branch(branch_id, name, address)
        values(@branch_id, @name, @address);
    end try
    begin catch
        throw;
    end catch
end;
go

--3- instructor table
create procedure sp_selectInstructor
as
begin
    set nocount on;
    select * from Instructor;
end;
go

create procedure sp_deleteInstructor(@instructor_id int)
as
begin
    set nocount on;
    delete from Instructor where instructor_id = @instructor_id;
end;
go

create procedure sp_updateInstructor(
    @instructor_id int,
    @name varchar(200) = null,
    @degree varchar(200) = null,
    @salary decimal(18,2) = null
)
as
begin
    set nocount on;
    update Instructor
    set name = coalesce(@name, name),
        degree = coalesce(@degree, degree),
        salary = coalesce(@salary, salary)
    where instructor_id = @instructor_id;
end;
go

create procedure sp_insertInstructor(
    @instructor_id int,
    @name varchar(200) = null,
    @degree varchar(200) = null,
    @salary decimal(18,2) = null
)
as
begin
    set nocount on;
    if @instructor_id is null
        throw 50020, 'instructor_id is required', 1;
    if @name is null
        throw 50021, 'name is required', 1;
    begin try
        insert into Instructor(instructor_id, name, degree, salary)
        values(@instructor_id, @name, @degree, @salary);
    end try
    begin catch
        throw;
    end catch
end;
go

--4- track table
create procedure sp_selectTrack
as
begin
    set nocount on;
    select * from Track;
end;
go

create procedure sp_deleteTrack(@track_id int)
as
begin
    set nocount on;
    delete from Track where track_id = @track_id;
end;
go

create procedure sp_updateTrack(
    @track_id int,
    @name varchar(200) = null,
    @supervisor_id int = null
)
as
begin
    set nocount on;
    update Track
    set name = coalesce(@name, name),
        supervisor_id = coalesce(@supervisor_id, supervisor_id)
    where track_id = @track_id;
end;
go

create procedure sp_insertTrack(
    @track_id int,
    @name varchar(200) = null,
    @supervisor_id int = null
)
as
begin
    set nocount on;
    if @track_id is null
        throw 50030, 'track_id is required', 1;
    if @name is null
        throw 50031, 'name is required', 1;
    begin try
        insert into Track(track_id, name, supervisor_id)
        values(@track_id, @name, @supervisor_id);
    end try
    begin catch
        throw;
    end catch
end;
go

--5- student table
create procedure sp_selectStudent
as
begin
    set nocount on;
    select * from Student;
end;
go

create procedure sp_deleteStudent(@studid int)
as
begin
    set nocount on;
    delete from Student where Student_id = @studid;
end;
go

create procedure sp_updateStudent(
    @studid int,
    @fname varchar(200) = null,
    @lname varchar(200) = null,
    @bd date = null
)
as
begin
    set nocount on;
    update Student
    set First_name = coalesce(@fname, First_name),
        Last_name = coalesce(@lname, Last_name),
        Birth_date = coalesce(@bd, Birth_date)
    where Student_id = @studid;
end;
go

create procedure sp_insertStudent(
    @studid int,
    @fname varchar(200) = null,
    @lname varchar(200) = null,
    @bd date = null
)
as
begin
    set nocount on;
    if @studid is null
        throw 50040, 'studid is required', 1;
    if @fname is null
        throw 50041, 'fname is required', 1;
    if @lname is null
        throw 50042, 'lname is required', 1;
    begin try
        insert into Student(Student_id, First_name, Last_name, Birth_date)
        values(@studid, @fname, @lname, @bd);
    end try
    begin catch
        throw;
    end catch
end;
go

--6- classoffering table
create procedure sp_selectClassOffering
as
begin
    set nocount on;
    select * from ClassOffering;
end;
go

create procedure sp_deleteClassOffering(@classoffering_id int)
as
begin
    set nocount on;
    delete from ClassOffering where classoffering_id = @classoffering_id;
end;
go

create procedure sp_updateClassOffering(
    @classoffering_id int,
    @intake_id int = null,
    @branch_id int = null,
    @track_id int = null
)
as
begin
    set nocount on;
    update ClassOffering
    set intake_id = coalesce(@intake_id, intake_id),
        branch_id = coalesce(@branch_id, branch_id),
        track_id = coalesce(@track_id, track_id)
    where classoffering_id = @classoffering_id;
end;
go

create procedure sp_insertClassOffering(
    @classoffering_id int,
    @intake_id int = null,
    @branch_id int = null,
    @track_id int = null
)
as
begin
    set nocount on;
    if @classoffering_id is null
        throw 50050, 'classoffering_id is required', 1;
    if @intake_id is null
        throw 50051, 'intake_id is required', 1;
    if @branch_id is null
        throw 50052, 'branch_id is required', 1;
    if @track_id is null
        throw 50053, 'track_id is required', 1;
    begin try
        insert into ClassOffering(classoffering_id, intake_id, branch_id, track_id)
        values(@classoffering_id, @intake_id, @branch_id, @track_id);
    end try
    begin catch
        throw;
    end catch
end;
go



-----//=========================================================================================================

-- answer table
create procedure sp_selectAnswer
as
begin
    set nocount on;
    select * from Answer;
end;
go

create procedure sp_deleteAnswer(@attempt_id int, @question_id int)
as
begin
    set nocount on;
    delete from Answer where Attempt_id = @attempt_id and Question_id = @question_id;
end;
go

create procedure sp_updateAnswer(
    @attempt_id int,
    @question_id int,
    @choice_id int = null,
    @grade int = null
)
as
begin
    set nocount on;
    update Answer
    set Choice_id = coalesce(@choice_id, Choice_id),
        Grade = coalesce(@grade, Grade)
    where Attempt_id = @attempt_id and Question_id = @question_id;
end;
go

create procedure sp_insertAnswer(
    @attempt_id int,
    @question_id int,
    @choice_id int = null,
    @grade int = null
)
as
begin
    set nocount on;
    if @attempt_id is null
        throw 50070, 'attempt_id is required', 1;
    if @question_id is null
        throw 50071, 'question_id is required', 1;
    begin try
        insert into Answer(Attempt_id, Question_id, Choice_id, Grade)
        values(@attempt_id, @question_id, @choice_id, @grade);
    end try
    begin catch
        throw;
    end catch
end;
go

-- choice table
create procedure sp_selectChoice
as
begin
    set nocount on;
    select * from Choice;
end;
go

create procedure sp_deleteChoice(@choice_id int)
as
begin
    set nocount on;
    delete from Choice where Choice_id = @choice_id;
end;
go

create procedure sp_updateChoice(
    @choice_id int,
    @choice_text varchar(255) = null,
    @is_correct bit = null,
    @question_id int = null
)
as
begin
    set nocount on;
    update Choice
    set Choice_text = coalesce(@choice_text, Choice_text),
        Is_correct = coalesce(@is_correct, Is_correct),
        Question_id = coalesce(@question_id, Question_id)
    where Choice_id = @choice_id;
end;
go

create procedure sp_insertChoice(
    @choice_id int,
    @choice_text varchar(255) = null,
    @is_correct bit = null,
    @question_id int = null
)
as
begin
    set nocount on;
    if @choice_id is null
        throw 50080, 'choice_id is required', 1;
    begin try
        insert into Choice(Choice_id, Choice_text, Is_correct, Question_id)
        values(@choice_id, @choice_text, @is_correct, @question_id);
    end try
    begin catch
        throw;
    end catch
end;
go

-- course table
create procedure sp_selectCourse
as
begin
    set nocount on;
    select * from Course;
end;
go

create procedure sp_deleteCourse(@course_id int)
as
begin
    set nocount on;
    delete from Course where Course_id = @course_id;
end;
go

create procedure sp_updateCourse(
    @course_id int,
    @name varchar(100) = null,
    @duration int = null
)
as
begin
    set nocount on;
    update Course
    set Name = coalesce(@name, Name),
        Duration = coalesce(@duration, Duration)
    where Course_id = @course_id;
end;
go

create procedure sp_insertCourse(
    @course_id int,
    @name varchar(100) = null,
    @duration int = null
)
as
begin
    set nocount on;
    if @course_id is null
        throw 50090, 'course_id is required', 1;
    begin try
        insert into Course(Course_id, Name, Duration)
        values(@course_id, @name, @duration);
    end try
    begin catch
        throw;
    end catch
end;
go

-- exam table
create procedure sp_selectExam
as
begin
    set nocount on;
    select * from Exam;
end;
go

create procedure sp_deleteExam(@exam_id int)
as
begin
    set nocount on;
    delete from Exam where Exam_id = @exam_id;
end;
go

create procedure sp_updateExam(
    @exam_id int,
    @name varchar(100) = null,
    @duration int = null,
    @no_of_questions int = null,
    @course_id int = null
)
as
begin
    set nocount on;
    update Exam
    set Name = coalesce(@name, Name),
        Duration = coalesce(@duration, Duration),
        No_of_questions = coalesce(@no_of_questions, No_of_questions),
        Course_id = coalesce(@course_id, Course_id)
    where Exam_id = @exam_id;
end;
go

create procedure sp_insertExam(
    @exam_id int,
    @name varchar(100) = null,
    @duration int = null,
    @no_of_questions int = null,
    @course_id int = null
)
as
begin
    set nocount on;
    if @exam_id is null
        throw 50100, 'exam_id is required', 1;
    begin try
        insert into Exam(Exam_id, Name, Duration, No_of_questions, Course_id)
        values(@exam_id, @name, @duration, @no_of_questions, @course_id);
    end try
    begin catch
        throw;
    end catch
end;
go

-- exam_attempt table
create procedure sp_selectExamAttempt
as
begin
    set nocount on;
    select * from Exam_Attempt;
end;
go

create procedure sp_deleteExamAttempt(@attempt_id int)
as
begin
    set nocount on;
    delete from Exam_Attempt where Attempt_id = @attempt_id;
end;
go

create procedure sp_updateExamAttempt(
    @attempt_id int,
    @total_score int = null,
    @student_id int = null,
    @exam_id int = null
)
as
begin
    set nocount on;
    update Exam_Attempt
    set Total_score = coalesce(@total_score, Total_score),
        Student_id = coalesce(@student_id, Student_id),
        Exam_id = coalesce(@exam_id, Exam_id)
    where Attempt_id = @attempt_id;
end;
go

create procedure sp_insertExamAttempt(
    @attempt_id int,
    @total_score int = null,
    @student_id int = null,
    @exam_id int = null
)
as
begin
    set nocount on;
    if @attempt_id is null
        throw 50110, 'attempt_id is required', 1;
    begin try
        insert into Exam_Attempt(Attempt_id, Total_score, Student_id, Exam_id)
        values(@attempt_id, @total_score, @student_id, @exam_id);
    end try
    begin catch
        throw;
    end catch
end;
go

-- exam_question table (composite pk)
create procedure sp_selectExamQuestion
as
begin
    set nocount on;
    select * from Exam_Question;
end;
go

create procedure sp_deleteExamQuestion(@exam_id int, @question_id int)
as
begin
    set nocount on;
    delete from Exam_Question where Exam_id = @exam_id and Question_id = @question_id;
end;
go

create procedure sp_updateExamQuestion(
    @exam_id int,
    @question_id int,
    @exam_id_new int = null,
    @question_id_new int = null
)
as
begin
    set nocount on;
    update Exam_Question
    set Exam_id = coalesce(@exam_id_new, Exam_id),
        Question_id = coalesce(@question_id_new, Question_id)
    where Exam_id = @exam_id and Question_id = @question_id;
end;
go

create procedure sp_insertExamQuestion(
    @exam_id int,
    @question_id int
)
as
begin
    set nocount on;
    if @exam_id is null
        throw 50120, 'exam_id is required', 1;
    if @question_id is null
        throw 50121, 'question_id is required', 1;
    begin try
        insert into Exam_Question(Exam_id, Question_id)
        values(@exam_id, @question_id);
    end try
    begin catch
        throw;
    end catch
end;
go

-- instructor_course table (composite pk)
create procedure sp_selectInstructorCourse
as
begin
    set nocount on;
    select * from Instructor_Course;
end;
go

create procedure sp_deleteInstructorCourse(@instructor_id int, @course_id int)
as
begin
    set nocount on;
    delete from Instructor_Course where Instructor_id = @instructor_id and Course_id = @course_id;
end;
go

create procedure sp_updateInstructorCourse(
    @instructor_id int,
    @course_id int,
    @instructor_id_new int = null,
    @course_id_new int = null
)
as
begin
    set nocount on;
    update Instructor_Course
    set Instructor_id = coalesce(@instructor_id_new, Instructor_id),
        Course_id = coalesce(@course_id_new, Course_id)
    where Instructor_id = @instructor_id and Course_id = @course_id;
end;
go

create procedure sp_insertInstructorCourse(
    @instructor_id int,
    @course_id int
)
as
begin
    set nocount on;
    if @instructor_id is null
        throw 50130, 'instructor_id is required', 1;
    if @course_id is null
        throw 50131, 'course_id is required', 1;
    begin try
        insert into Instructor_Course(Instructor_id, Course_id)
        values(@instructor_id, @course_id);
    end try
    begin catch
        throw;
    end catch
end;
go

-- question table
create procedure sp_selectQuestion
as
begin
    set nocount on;
    select * from Question;
end;
go

create procedure sp_deleteQuestion(@question_id int)
as
begin
    set nocount on;
    delete from Question where Question_id = @question_id;
end;
go

create procedure sp_updateQuestion(
    @question_id int,
    @number int = null,
    @text varchar(max) = null,
    @type varchar(50) = null
)
as
begin
    set nocount on;
    update Question
    set Number = coalesce(@number, Number),
        Text = coalesce(@text, Text),
        Type = coalesce(@type, Type)
    where Question_id = @question_id;
end;
go

create procedure sp_insertQuestion(
    @question_id int,
    @number int = null,
    @text varchar(max) = null,
    @type varchar(50) = null
)
as
begin
    set nocount on;
    if @question_id is null
        throw 50140, 'question_id is required', 1;
    begin try
        insert into Question(Question_id, Number, Text, Type)
        values(@question_id, @number, @text, @type);
    end try
    begin catch
        throw;
    end catch
end;
go

-- student_enrollment table (composite pk)
create procedure sp_selectStudentEnrollment
as
begin
    set nocount on;
    select * from Student_Enrollment;
end;
go

create procedure sp_deleteStudentEnrollment(@student_id int, @class_offering_id int)
as
begin
    set nocount on;
    delete from Student_Enrollment where Student_id = @student_id and Class_offering_id = @class_offering_id;
end;
go

create procedure sp_updateStudentEnrollment(
    @student_id int,
    @class_offering_id int,
    @student_id_new int = null,
    @class_offering_id_new int = null
)
as
begin
    set nocount on;
    update Student_Enrollment
    set Student_id = coalesce(@student_id_new, Student_id),
        Class_offering_id = coalesce(@class_offering_id_new, Class_offering_id)
    where Student_id = @student_id and Class_offering_id = @class_offering_id;
end;
go

create procedure sp_insertStudentEnrollment(
    @student_id int,
    @class_offering_id int
)
as
begin
    set nocount on;
    if @student_id is null
        throw 50150, 'student_id is required', 1;
    if @class_offering_id is null
        throw 50151, 'class_offering_id is required', 1;
    begin try
        insert into Student_Enrollment(Student_id, Class_offering_id)
        values(@student_id, @class_offering_id);
    end try
    begin catch
        throw;
    end catch
end;
go

-- topic table
create procedure sp_selectTopic
as
begin
    set nocount on;
    select * from Topic;
end;
go

create procedure sp_deleteTopic(@topic_id int)
as
begin
    set nocount on;
    delete from Topic where Topic_id = @topic_id;
end;
go

create procedure sp_updateTopic(
    @topic_id int,
    @name varchar(100) = null,
    @course_id int = null
)
as
begin
    set nocount on;
    update Topic
    set Name = coalesce(@name, Name),
        Course_id = coalesce(@course_id, Course_id)
    where Topic_id = @topic_id;
end;
go

create procedure sp_insertTopic(
    @topic_id int,
    @name varchar(100) = null,
    @course_id int = null
)
as
begin
    set nocount on;
    if @topic_id is null
        throw 50160, 'topic_id is required', 1;
    begin try
        insert into Topic(Topic_id, Name, Course_id)
        values(@topic_id, @name, @course_id);
    end try
    begin catch
        throw;
    end catch
end;
go

-- track_course table (composite pk)
create procedure sp_selectTrackCourse
as
begin
    set nocount on;
    select * from Track_Course;
end;
go

create procedure sp_deleteTrackCourse(@track_id int, @course_id int)
as
begin
    set nocount on;
    delete from Track_Course where Track_id = @track_id and Course_id = @course_id;
end;
go

create procedure sp_updateTrackCourse(
    @track_id int,
    @course_id int,
    @track_id_new int = null,
    @course_id_new int = null
)
as
begin
    set nocount on;
    update Track_Course
    set Track_id = coalesce(@track_id_new, Track_id),
        Course_id = coalesce(@course_id_new, Course_id)
    where Track_id = @track_id and Course_id = @course_id;
end;
go

create procedure sp_insertTrackCourse(
    @track_id int,
    @course_id int
)
as
begin
    set nocount on;
    if @track_id is null
        throw 50170, 'track_id is required', 1;
    if @course_id is null
        throw 50171, 'course_id is required', 1;
    begin try
        insert into Track_Course(Track_id, Course_id)
        values(@track_id, @course_id);
    end try
    begin catch
        throw;
    end catch
end;
go
