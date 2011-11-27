require 'fileutils'

desc 'Setup Lists for development / deploy'
task :setup do

  # Setup config files
  database     = File.join(Rails.root, 'config', 'database.yml')
  secret_token = File.join(Rails.root, 'config', 'initializers', 'secret_token.rb')
  omniauth     = File.join(Rails.root, 'config', 'initializers', 'omniauth.rb')

  unless File.exists?(database)
    FileUtils.cp(database + '.example', database)
    puts "Database config file created"
    `$EDITOR #{database}`
  end

  unless File.exists?(secret_token)
    # TODO: Generate secret_token.rb.erb and copy into place
  end

  unless File.exists?(omniauth)
    FileUtils.cp(omniauth + '.example', omniauth)
    puts "Omniauth config file created"
    `$EDITOR #{omniauth}`
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
