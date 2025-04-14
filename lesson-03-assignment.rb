
  # 1 What tables do you need to add? Decide on table names and their associations to each other and any existing tables/models.
### topic - to store name like, SQL, CSS, etc...
  ### has many lessons
### lesson - was already there... 
### lesson_topic - to join the two tables
  ### has many topics

  # 2 What columns are necessary for the associations you decided on?
### table: topics with attributes, id, name, created_at, updated_at 
### table: lesson_topics with id, lesson_id, topic_id, created_at, updated_at

  # 3 What other columns (if any) need to be included on the tables? What other data needs to be stored?
### topics could have a description?

  # 4 Write out each table's name and column names with data types.
  # table: topics
  # columns
  # - id : int
  # - name : string
  # - created_at : datetime
  # - updated_at : datetime 

  # table: lesson_topics 
  # columns
  # - id : int 
  # - lesson_id : int (fk)
  # - topic_id : int (fk)
  # - created_at : datetime
  # - updated_at : datetime 

  # 5 Determine the generator command you'll need to create the migration file and run the command to generate the empty migration file. Start with just the topics migration. (Hint: your filename should be create_topics)
  ### bin/rails generate migration create_topics name:string 
