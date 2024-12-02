# frozen_string_literal: true

require 'csv'

namespace :hexlet do
  desc 'Import users from a CSV file'
  task import_users: :environment do |task, args|
    file_path = args.extras[0]

    unless file_path && File.exist?(file_path)
      puts 'Error: Please provide a valid file path as an argument.'
      puts 'Example: bin/rails "hexlet:import_users[test/fixtures/files/users.csv]"'
      exit 1
    end

    CSV.foreach(file_path, headers: true) do |row|
      User.create!(
        first_name: row['first_name'],
        last_name: row['last_name'],
        birthday: Date.strptime(row['birthday'], '%m/%d/%Y'),
        email: row['email']
      )
    end

    puts 'Users imported successfully!'
    puts "Total users in database: #{User.count}"
  rescue StandardError => e
    puts "Error during import: #{e.message}"
  end
end
