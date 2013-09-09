namespace :db do 
  task :migrate do
    require "sequel"
    Sequel.extension :migration
    DB = Sequel.postgres("farmsubsidy_development")
    Sequel::Migrator.run(DB, './db/migrations', :use_transactions=>true)
  end

  task :set_up_performance_test_db do
    require "sequel"
    Sequel.extension :migration

    #check to see if performance DB already exists
    the_database_is_there = system("psql -l | grep farmsubsidy_performance")
    if the_database_is_there
      #if it does then drop the db 
      system("dropdb farmsubsidy_performance")
    end
    #and recreate it
    system("createdb farmsubsidy_performance")

    DB = Sequel.postgres("farmsubsidy_performance")
    Sequel::Migrator.run(DB, './db/migrations', :use_transactions=>true)
  end

  task :run_any_new_migration do
    require "sequel"
    Sequel.extension :migration

    DB = Sequel.postgres("farmsubsidy_performance")
    Sequel::Migrator.run(DB, './db/migrations', :use_transactions=>true)
  end
end



