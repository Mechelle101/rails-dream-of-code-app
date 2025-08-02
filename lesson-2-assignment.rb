# Creating and Updating Data with ActiveRecord
# Q1: Finishing Task 2, Add course, enrollments and mentor
spring2026 = Trimester.find_by(year: '2026', term: 'Spring')
doc-rails(dev)* CodingClass.all.each do |cc|
doc-rails(dev)*   puts cc.title
doc-rails(dev)> end
# I think this gave me an infinite loop. Not sure why...Starting over
spring2026 = Trimester.find_by(year: '2026', term: 'Spring')
cc = CodingClass.first
Course.create(coding_class: cc, trimester: spring2026)
# Creating a new course for each coding class in spring 2026
CodingClass.all.each do |cc|
Course.create(coding_class: cc, trimester: spring2026)
end
# Q2: Create a Student, Enroll them, and Assign a mentor with <= 2 students
# create a student, and save using create()
new_student = Student.create(first_name: 'Mechelle', last_name: 'Presnell', email: 'me.pr@example.com')
# testing
doc-rails(dev)> new_student.persisted?
=> true
# Find the intro to programming course for spring 2026
intro_class = CodingClass.find_by(title: 'Intro to Programming')
# getting the correct Course record to enroll the student in
course = Course.find_by(coding_class: intro_class, trimester: spring2026)
# Now enroll the student
enrollment = Enrollment.create(student: new_student, course: course)
# Now find the mentor with <= 2 enrollments
# here's the loop that finds the mentors.
doc-rails(dev)* Mentor.all.each do |m|
doc-rails(dev)*   puts "#{m.first_name} #{m.last_name}: #{m.mentor_enrollment_assignments.count} enrollments"
doc-rails(dev)> end
# There was an error and it took a minute but i realized i needed to add the has_many to mentor.rb
  has_many :mentor_enrollment_assignments
  has_many :enrollments, through: :mentor_enrollment_assignments
  MentorEnrollmentAssignment Count (0.1ms)  SELECT COUNT(*) FROM "mentor_enrollment_assignments" WHERE "mentor_enrollment_assignments"."mentor_id" = 31 application='DocRails' Frank Smith: 1 enrollments
  MentorEnrollmentAssignment Count (0.1ms)  SELECT COUNT(*) FROM "mentor_enrollment_assignments" WHERE "mentor_enrollment_assignments"."mentor_id" = 22 application='DocRails' Angelo Blick: 2 enrollments
# Assigning them to Frank
mentor = Mentor.find_by(id: 31)
 MentorEnrollmentAssignment.create(mentor: mentor, enrollment: enrollment)
#  now to confirm
enrollment.mentor_enrollment_assignments

# Q3: Describing my Project
# My project is called **Wellness Tracker**. It helps users monitor their health habits by allowing them to log daily wellness entries, track their supplement usage, and categorize activities such as sleep, exercise, mood, hydration, etc.

# **Who are the users?**
# The users are individuals who want to improve or maintain their well-being by tracking their habits. Currently, there’s only one user role: regular users who track their own wellness data.

# **What can users do in the app?**
# - A user can register an account and log in to view their dashboard
# - A user can create a daily wellness entry that includes journal notes, activities, or health indicators
# - A user can tag entries with one or more categories (like "Exercise", "Sleep", or "Mood")
# - A user can view their past entries and filter by date or category
# - A user can add supplements they take (e.g., Vitamin D, Creatine) and optionally set reminders for them
# - A user can manage their personal reminders for wellness tasks like “Take vitamin C” or “Drink 8 glasses of water”

# This app helps users reflect on their daily routines and build better habits over time.

# Attributes and Relationships
# **Models and Attributes**

# 1. **Users**
# - id
# - first_name
# - last_name
# - email
# - password_digest
# - created_at, updated_at

# Associations:
# - has_many :entries
# - has_many :reminders
# - has_many :supplements

# ---

# 2. **Entries**
# - id
# - user_id
# - date
# - notes
# - created_at, updated_at

# Associations:
# - belongs_to :user
# - has_many :entry_categories
# - has_many :categories, through: :entry_categories

# ---

# 3. **Categories**
# - id
# - name (e.g., "Sleep", "Exercise", "Mood", "Nutrition")
# - created_at, updated_at

# Associations:
# - has_many :entry_categories
# - has_many :entries, through: :entry_categories

# ---

# 4. **EntryCategories** (join table for entries and categories)
# - id
# - entry_id
# - category_id

# Associations:
# - belongs_to :entry
# - belongs_to :category

# ---

# 5. **Supplements**
# - id
# - user_id
# - name
# - dosage (string or integer)
# - frequency (e.g., daily, weekly)
# - created_at, updated_at

# Associations:
# - belongs_to :user

# ---

# 6. **Reminders**
# - id
# - user_id
# - message (e.g., "Take Creatine", "Drink Water")
# - frequency (e.g., daily, every 3 days)
# - time_of_day
# - created_at, updated_at

# Associations:
# - belongs_to :user

# Q4: The Data Model Description
# Users
# - id
# - first_name
# - last_name
# - email
# - password_digest

# Entries
# - id
# - user_id
# - date
# - notes

# Categories
# - id
# - name

# EntryCategories
# - id
# - entry_id
# - category_id

# Supplements
# - id
# - user_id
# - name
# - dosage
# - frequency

# Reminders
# - id
# - user_id
# - message
# - frequency
# - time_of_day