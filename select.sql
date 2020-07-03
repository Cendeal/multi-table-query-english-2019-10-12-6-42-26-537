# 1.Query the existence of 1 course
select * from course where id=1;
# 2.Query the presence of both 1 and 2 courses
select * from course where id=1 or id=2;
# 3.Query the student number and student name and average score of students whose average score is 60 or higher.
select std.id, std.name, average
from student as std
         join (select studentId, AVG(score) as average
               from student_course
               group by studentId
               having average >= 60)
              on std.id = studentId;
# 4.Query the SQL statement of student information that does not have grades in the student_course table
select student.*
from student
         left join student_course on studentId = student.id
where score IS NULL;
# 5.Query all SQL with grades
select student.id, student.name as name, sc.name as course, sc.score as grade
from student
         right join((select studentId, course.name, score
                     from student_course
                              right join course on courseId = course.id) as sc) on id = sc.studentId;
# 6.Inquire about the information of classmates who have numbered 1 and also studied the course numbered 2
select student.*
from student,
     student_course
where studentId = student.id
  and courseId = 1
  and studentId in (select studentId
                    from student_course
                    where courseId = 2);
# 7.Retrieve 1 student score with less than 60 scores in descending order
select student.*, score
from student,
     student_course
where studentId = student.id
  and courseId = 1
  and score < 60
order by score desc;
# 8.Query the average grade of each course. The results are ranked in descending order of average grade. When the average grades are the same, they are sorted in ascending order by course number.
select course.*, avg(score) as average
from course,
     student_course
where courseId = course.id
group by courseId
order by average desc, courseId;
# 9.Query the name and score of a student whose course name is "Math" and whose score is less than 60
select student.name, score
from student,
     student_course,
     course
where studentId = student.id
  and courseId = course.id
  and course.name = 'Math'
  and score < 60;