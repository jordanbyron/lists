require 'fileutils'

desc 'Setup Lists for development / deploy'
task :setup do

  # Setup config files
  database_file = File.join(Rails.root, 'config', 'database.yml')
  secret_token  = File.join(Rails.root, 'config', 'initializers', 'secret_token.rb')

  unless File.exists?(database_file)
    FileUtils.cp(database_file + '.example', database_file)
    puts "Database config file created"
    `$EDITOR #{database_file}`
  end

  unless File.exists?(secret_token)
    # TODO: Generate secret_token.rb.erb and copy into place
  end

  puts "Config files created"

  # Setup the database
  Rake::Task["db:create"].invoke
  Rake::Task["db:migrate"].invoke
  Rake::Task["db:test:prepare"].invoke

  puts "Database prepared"

  # Setup seed data
  Rake::Task["db:seed"].invoke

  puts "Seed data loaded"

  # Run the tests
  Rake::Task["test"].invoke

  puts "--- Setup Complete ---"

end
