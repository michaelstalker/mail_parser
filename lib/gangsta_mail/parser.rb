module GangstaMail
  class Parser
    def self.fetch_header(raw_email)
      email_parts = raw_email.split "\n\n"
      email_parts.first
    end
    
    def self.fetch_body(raw_email)
      email_parts = []
      raw_email.each_line('') { |line| email_parts << line }
      email_parts.delete_at 0
      body = email_parts.join ''
      body
    end
    
    def self.parse_header(header)
      fields = {}
      header_array = header.split "\n"
      header_array.each do |field|
        key_value = field.split(': ')
        fields[key_value.first.downcase.to_sym] = key_value[1]
      end
      fields
    end
  end
end