# Question 1
# For each CodingClass, create a new Course record for that class in the Spring 2026 trimester. 
# checking that the Trimester for Spring 2026 exists, at first i did season. Of course it gave me an error, "ActiveRecord::StatementInvalid"
spring_2026 = Trimester.find_or_create_by!(term: 'Spring', year: 2026)

# Now the loop
doc-rails(dev)* CodingClass.all.each do |cc|
  doc-rails(dev)*   Course.create!    (coding_class: cc, trimester: spring_2026)
doc-rails(dev)> end

# I think I created a duplicate 
Course.create!(coding_class: cc, trimester: spring_2026)

# I'm going to check
doc-rails(dev)> Course.where(coding_class: cc, trimester: spring_2026).count
  Course Count (0.2ms)  SELECT COUNT(*) FROM "courses" WHERE "courses"."coding_class_id" = 1 AND "courses"."trimester_id" = 8 /*application='DocRails'*
=> 2

# now i want to look at them, and here iss the output.
doc-rails(dev)> Course.where(coding_class: cc, trimester: spring_2026)
  Course Load (0.2ms)  SELECT "courses".* FROM "courses" WHERE "courses"."coding_class_id" = 1 AND "courses"."trimester_id" = 8 /* loading for pp */ LIMIT 11 /*application='DocRails'*
=> 
[#<Course:0x00000001223ceb00
  id: 36,
  coding_class_id: 1,
  trimester_id: 8,
  max_enrollment: nil,
  created_at: "2025-03-26 13:15:43.484737000 +0000",
  updated_at: "2025-03-26 13:15:43.484737000 +0000">,
 #<Course:0x00000001223ce740
  id: 41,
  coding_class_id: 1,
  trimester_id: 8,
  max_enrollment: nil,
  created_at: "2025-03-26 13:18:11.564224000 +0000",
  updated_at: "2025-03-26 13:18:11.564224000 +0000">]
doc-rails(dev)> 

# I'm not sure why it's red in this file but in my console it gave me the output, Anyway there was a / ... / that was causing it. Not sure why 

# deleting the duplicate
duplicates = Course.where(coding_class: cc, trimester: spring_2026)
course_to_delete = duplicates.last
course_to_delete.destroy

# Question 2
# Create a new student
student = Student.create!(first_name: 'Mechelle', last_name: 'Presnell', email: 'mp@gmail.com')

# finding the course for intro to programming in spring 2026
spring_2026 = Trimester.find_by(term: 'Spring', year: 2026)
intro_class = CodingClass.find_by(title: 'Intro to Programming')
course = Course.find_by(coding_class: intro_class, trimester: spring_2026)
# checking the id
doc-rails(dev)> puts course.id
36
=> nil

# enroll the student in that course
enrollment = Enrollment.create!(student: student, course: course)

# I got confused at this point
# I started at the top of Question 2 and double checked that a student I created was there
Student.find_by(first_name: 'Mechelle')

# Enroll the student in the correct class "intro to programming"
# find the course
course = Course.joins(:coding_class, :trimester).

# now checking everything over again...
Student.find_by(first_name: 'Mechelle', last_name: 'Presnell')
id: 51,
first_name: "Mechelle",
last_name: "Presnell",
email: "[FILTERED]",
created_at: "2025-03-26 14:13:22.872449000 +0000",
updated_at: "2025-03-26 14:13:22.872449000 +0000">

Student.find_by(first_name: 'Mechelle').enrollments.map { |e| [e.course.coding_class.title, e.course.trimester.term, e.course.trimester.year]  }
=> [["Intro to Programming", "Spring", "2026"]]

# find the enrollment record and printing it
Student.find_by(first_name: 'Mechelle').enrollments.first
puts enrollment.id
91
=> nil

#  find a mentor with 2 or fewer enrollments, looping through each mentor looking for count <= 2
mentor = Mentor.all.find do |m|
  MentorEnrollmentAssignment.where(mentor_id: m.id).count <= 2
 end

 doc-rails(dev)> mentor
 => 
 #<Mentor:0x0000000126101a40
  id: 22,
  first_name: "Elvis",
  last_name: "Witting",
  email: "[FILTERED]",
  max_concurrent_students: nil,
  created_at: "2025-03-17 19:58:18.897641000 +0000",
  updated_at: "2025-03-17 19:58:18.897641000 +0000">
 doc-rails(dev)> mentor.id
 => 22
 doc-rails(dev)> mentor.first_name
 => "Elvis"
 doc-rails(dev)> 

#  assign that mentor to the new student enrollment
# find the student's enrollment, it looks like i need to reassign the enrollment variable
enrollment = Student.find_by(first_name: 'Mechelle').enrollments.find_by(course_id: course.id)
# just in case it was not pointing to the right course
course = Course.joins(:coding_class, :trimester).find_by(coding_classes: {title: 'Intro to Programming'}, trimester: {term: 'Spring', year: 2026})

# create a mentor assignment
MentorEnrollmentAssignment.create!(mentor_id: mentor.id, enrollment_id: enrollment.id)

# checking that the mentor assignment exists
MentorEnrollmentAssignment.last
# then i ran this and got an error
Student.find_by(first_name: 'Mechelle').enrollments.last.mentors
  Student Load (0.2ms)  SELECT "students".* FROM "students" WHERE "students"."first_name" = 'Mechelle' LIMIT 1 *application='DocRails'*
  Enrollment Load (0.1ms)  SELECT "enrollments".* FROM "enrollments" WHERE "enrollments"."student_id" = 51 ORDER BY "enrollments"."id" DESC LIMIT 1 /*application='DocRails'*
(doc-rails):36:in '<top (required)>': undefined method 'mentors' for an instance of Enrollment (NoMethodError)
Did you mean?  methods

# trying something different
MentorEnrollmentAssignment.find_by(enrollment_id: enrollment.id).mentor
id: 22,
 first_name: "Elvis",
 last_name: "Witting",
 email: "[FILTERED]",
 max_concurrent_students: nil,
 created_at: "2025-03-17 19:58:18.897641000 +0000",
 updated_at: "2025-03-17 19:58:18.897641000 +0000">

#  just for fun, altered enrollment.rb so the line would work
Student.find_by(first_name: 'Mechelle').enrollments.last.mentors
#<Mentor:0x00000001268fb908
id: 22,
first_name: "Elvis",
last_name: "Witting",
email: "[FILTERED]",
max_concurrent_students: nil,
created_at: "2025-03-17 19:58:18.897641000 +0000",
updated_at: "2025-03-17 19:58:18.897641000 +0000">

# Project Description - Wellness Tracker
# The wellness tracker will be a simple web application designed to help users monitor and improve their overall health and wellness.

# The users for the application
# The app will be intended for individual users who want to track personal wellness metrics, such as mood, sleep, water intake, and exercise. 
# There will be one type of user: the individual tracker. In the future there could be more users like health coaches and doctors as additional user rolls. 

# The core features of the app
# A user can register and login to their personal wellness dashboard.
# A user can log daily entries:
  # Mood... (happy, anxious, tired)
  # Sleep... (hours of sleep)
  # Water intake... (ounces or cups)
  # Physical activity... (type, duration)
  # Nates... (optional journal style nates, or just journalizing)
# a user can view their wellness history in a timeline or calendar view.
# a user can can visualize patterns with basic charts... (sleep vs mood)
# A user can set goals... (8 hours of sleep, 64 oz of water) and track progress

# User flow example
# 1. User signs up and logs in
# 2. User creates a new daily log entry
# 3. The dashboard displays trends and insights from past logs
# 4. User sets personal wellness goals and tracks how consistently they're meeting them

# Core features of the app might include
# - Log daily wellness entries 
# - Track meals and nutrition
# - Set reminders for wellness habits (stretching, meditation, supplements)
# - Review trends in their data over time to see progress or patterns
# - Later could include nutrition logging

# This app will help users stay accountable and see measurable progress in their wellness journey

# Tables
# User - the person using the app
# Entry - a daily log, or check-in
# NutritionLog - a record of food, nutrition info on a given day
# Reminder - a custom alert/reminder set by the user
# Category - tags for entry types

# Define Relationships
# A User had many Entries
# A User has many Reminders
# A User has many NutritionLogs
# An Entry can Entry can belong to a Category(for tagging)

# users
# id
# first_name
# last_name
# email
# password_hashed? 
# created_at
# updated_at

# entries
# id
# user_id(FK)
# title
# content
# date
# mood(integer 1-10)
# energy_level(integer 1-10)
# sleep_hours
# hydration_oz
# notes
# created_at
# updated_at

# nutrition_log
# id
# user_id(FK)
# meal_type(breakfast,lunch,dinner,snack)
# food_type
# calories
# protein_grm
# carbs_grm
# fats_grm
# notes
# created_at
# updated_at

# reminders
# id
# user_id(FK)
# title
# description
# remind_at(datetime)
# frequency(daily,weekly)
# created_at
# updated_at

# supplements
# id
# user_id(FK)
# name
# dose
# unit(mg,ml)
# taken_at(timestamp)
# notes
# created_at
# updated_at

# categories
# id
# name(workout,meditation,hydration)
# created_at
# updated_at

# entry_categories(join table for entries and categories)
# id
# entry_id
# category_id
