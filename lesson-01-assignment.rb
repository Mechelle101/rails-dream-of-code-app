# Q1: Collect emails for students in the Intro course
intro_class = CodingClass.find_by(title: "Intro to Programming")
spring_2025 = Trimester.find_by(year: "2025", term: "Spring")
intro_course = Course.find_by(coding_class_id: intro_class.id, trimester_id: spring_2025.id)
enrollments =  Enrollment.where(course_id: intro_course.id)
doc-rails(dev)* enrollments.first(2).each do |enrollment|
doc-rails(dev)*   student = Student.find(enrollment.student_id)
doc-rails(dev)*   puts "#{student.id}, #{student.email}"
doc-rails(dev)> end

<41> <filiberto.leuschke@reichert.example>
<42> <zenaida_raynor@rice-rowe.example>

# Q2: Email all mentors who have not assigned a final grade
enrollments = Enrollment.where(course_id: intro_course.id)
ungraded = enrollments.where(final_grade: nil)
doc-rails(dev)* ungraded.first(2).each do |enrollment|
doc-rails(dev)*   assignment = MentorEnrollmentAssignment.find_by(enrollment_id: enrollment.id)
doc-rails(dev)*   if assignment
doc-rails(dev)*     mentor = Mentor.find(assignment.mentor_id)
doc-rails(dev)*     puts "#{mentor.id}, #{mentor.email}"
doc-rails(dev)*   end
doc-rails(dev)> end
<25> <melonie.hegmann@hills-witting.example>
<26> <palmer.welch@heller.test>