namespace :hexlet do
  desc 'Импорт пользователей из CSV-файла'
  task import_users: :environment do |_task, args|
    require 'csv'

    file_path = args.extras[0]
    unless file_path && File.exist?(file_path)
      puts 'Укажите корректный путь к CSV-файлу'
      exit 1
    end

    begin
      CSV.foreach(file_path, headers: true) do |row|
        User.create!(
          name: row['name'],
          email: row['email'],
          created_at: row['created_at'],
          updated_at: row['updated_at']
        )
      end
      puts 'Импорт завершен успешно!'
    rescue StandardError => e
      puts "Ошибка при импорте: #{e.message}"
      exit 1
    end
  end
end
