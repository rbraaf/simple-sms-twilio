class Sms
  attr_reader :first_name, :phone_number

  @contacts = []

  def initialize
    puts "Please enter the name"
    @first_name = gets.chomp.capitalize
    puts "Please enter a phone number with area code"
    @phone_number = gets.chomp.gsub(/\D/, "")
  end

  def self.add_to_contacts
    contact = new
    @contacts << contact
  end

  def self.all
    @contacts.each do |contact|
      puts "#{contact.first_name} -- +1#{contact.phone_number}"
    end
  end

  def self.select_contact
    puts "Please choose a contact:"
    Sms.all
    selected_contact = gets.chomp.downcase
    @contacts.each do |contact|
      if selected_contact == contact.first_name.downcase
        @number = contact.phone_number
      else
        puts "Contact does not exist"
      end
    end
    @number
  end

  def self.add_contact
    puts "Add a contact. To exit type \'done\'"
    i = nil
    until i == "done"
      Sms.add_to_contacts
      puts "Add or done?"
      i = gets.chomp.downcase
    end
  end

  def self.get_sms_body
    puts "Enter a message:"
    message = gets.chomp
  end

  def self.message_contact
    number = Sms.select_contact
    body = Sms.get_sms_body

    env = YAML::load(File.open('secrets.yml'))

    account_sid = env["ACCOUNT_SID"]
    auth_token = env["AUTH_TOKEN"]

    @client = Twilio::REST::Client.new account_sid, auth_token

    @client.messages.create(
      from: '+19404884275',
      to: "+1#{number}",
      body: "#{body}"
    )
  end
end
