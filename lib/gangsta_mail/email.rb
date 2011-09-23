require_relative 'parser'

module GangstaMail
  class Email
    
    attr_reader :raw_email,
                :from,
                :date,
                :to,
                :subject,
                :cc,
                :content_type,
                :reply_to
    
    def initialize(raw_email)
      @raw_email = raw_email
      @from = header_fields[:from]
      @date = header_fields[:date]
      @to = header_fields[:to]
      @subject = header_fields[:subject]
      @cc = header_fields[:cc]
      @content_type = header_fields[:content_type]
      @reply_to = header_fields[:reply_to]      
    end
    
    def header
      GangstaMail::Parser.fetch_header @raw_email
    end
    
    def body
      GangstaMail::Parser.fetch_body @raw_email
    end
    
    private
    
    def header_fields
      GangstaMail::Parser.parse_header self.header
    end
  end
end