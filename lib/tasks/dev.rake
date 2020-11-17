namespace :dev do

  DEFAULT_PASSWORD = 123456
  DEFAULT_FILE_PATH = File.join(Rails.root, 'lib', 'tmp')

  desc "Configura o Ambiente de Desenvolvimento"
  task setup: :environment do
    if Rails.env.development?
      show_spinner("Apagando DB..") { %x(rails db:drop) }        
      show_spinner("Criando DB..") { %x(rails db:create) }        
      show_spinner("Migrando DB..") { %x(rails db:migrate) }      
      show_spinner("Criando o usuários padrão..") { %x(rails dev:add_default_user) }      
      show_spinner("Criando o administradores o padrão..") { %x(rails dev:add_default_admin) }   
      show_spinner("Criando novos administradores..") { %x(rails dev:add_new_admin) }   
      show_spinner("Criando assuntos padrões..") { %x(rails dev:add_subjects) }   
      show_spinner("Criando perguntas e respostas..") { %x(rails dev:add_answers_and_questions) }   
    else
      puts "Você não está em ambiente de desenvolvimento!"  
    end
  end

  desc "Adiciona o Usuário Padrão"
  task add_default_user: :environment do
    User.create!(
      email: 'paco@paco.com',
      password: DEFAULT_PASSWORD,
      password_confirmation: DEFAULT_PASSWORD
    )
  end
  
  desc "Adiciona o Administrador Padrão"
  task add_default_admin: :environment do
    Admin.create!(
      email: 'admin@admin.com',
      password: DEFAULT_PASSWORD,
      password_confirmation: DEFAULT_PASSWORD
    )
  end

  desc "Adiciona administradores extras"
  task add_new_admin: :environment do
    10.times do |i|
      Admin.create!(
        email: Faker::Internet.email,
        password: DEFAULT_PASSWORD,
        password_confirmation: DEFAULT_PASSWORD
      )
    end
  end

  desc "Adiciona assuntos padrões"
  task add_subjects: :environment do 
    file_name = 'subjects.txt'
    file_path = File.join(DEFAULT_FILE_PATH, file_name)
    File.open(file_path, 'r').each do |line|
      Subject.create!(description: line.strip)
    end
  end

  desc "Adiciona perguntas e respostas"
  task add_answers_and_questions: :environment do 
    Subject.all.each do |subject|
      rand(5..10).times do |i|
        Question.create!(
          description: "#{Faker::Lorem.paragraph} #{Faker::Lorem.question}",
          subject: subject
        )
      end
    end
  end

  private
  def show_spinner(msg_start, msg_end = "Concluído!")
    spinner = TTY::Spinner.new("[:spinner] #{msg_start}")
    spinner.auto_spin
    yield
    spinner.success("(#{msg_end})")
    
  end

end
