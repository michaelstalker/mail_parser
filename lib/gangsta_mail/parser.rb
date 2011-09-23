module GangstaMail
  class Parser
    def self.fetch_header(raw_email)
      email_parts = raw_email.split "\n\n"
      email_parts.first
    end
    
    def self.fetch_body(raw_email)
      email_sections = group_email_sections raw_email
      discard_header! email_sections
      body = email_sections.join ''
      body
    end
    
    def self.parse_header(header)
      header_array = header.split "\n"
      fields = keys_and_values header_array
      fields
    end
    
    private
    
    # Group the header in one array element, and the body in one or more array
    # elements
    def self.group_email_sections(raw_email)
      email_sections = []
      raw_email.each_line('') { |line| email_sections << line }
      email_sections
    end
    
    def self.discard_header!(email_parts)
      email_parts.delete_at 0
    end
    
    def self.keys_and_values(header_array)
      fields = {}
      header_array.each do |field|
        key_value_pair = field.split(': ')
        key = key_value_pair.first
        key = format_key key
        fields[key] = key_value_pair[1]
      end
      fields
    end
    
    def self.format_key(key)
      key.downcase.gsub('-', '_').to_sym
    end
  end
end