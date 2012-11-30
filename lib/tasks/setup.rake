desc 'Setup Lists for development / deploy'
setup_task :setup do

  section "Configuration Files" do
    
    database_file = File.join(Rails.root, 'config', 'database.yml')
    secret_token  = File.join(Rails.root, 'config', 'initializers', 'secret_token.rb')
    omniauth      = File.join(Rails.root, 'config', 'initializers', 'omniauth.rb')

    find_or_create_file database_file, "database.yml", true

    done "database.yml"

    unless File.exists?(secret_token)
      secret   = SecureRandom.hex(64)
      template = ERB.new(File.read(secret_token + '.example'))

      File.open(secret_token, 'w') {|f| f.write(template.result(binding)) }
    end

    done "Secret Token"
    
    find_or_create_file omniauth, "Omniauth", true
    
    done "Omniauth"
  end

  section "Database" do
    begin
      # Check if there are pending migrations
      silence { Rake::Task["db:abort_if_pending_migrations"].invoke }
      done "Skip: Database already setup"
    rescue Exception
      silence do
        Rake::Task["db:create"].invoke
        Rake::Task["db:schema:load"].invoke
      end
      done "Database setup"
    end
  end

  puts # Empty Line
  puts %{#{'===='.color(:green)} Setup Complete #{'===='.color(:green)}}
  puts # Empty Line

  if console.agree("Would you like to run the test suite? (y/n)")
    silence { Rake::Task["db:test:prepare"].invoke }
    Rake::Task["test"].invoke
  end

end
