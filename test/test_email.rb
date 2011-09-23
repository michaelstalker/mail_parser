require 'test/unit'
require 'shoulda'
require 'redgreen'
require_relative '../lib/gangsta_mail/email'

class TestEmail < Test::Unit::TestCase

  RAW_EMAIL = %(MIME-Version: 1.0
Received: by 10.236.95.44 with HTTP; Thu, 22 Sep 2011 18:21:36 -0700 (PDT)
Date: Thu, 22 Sep 2011 21:21:36 -0400
Delivered-To: the.sphinx@example.com
Message-ID: <CACy8cYDTK0_ra68Wb_X99doKQDErZKNn+8VOVahV6_fdbTdq7A@mail.gmail.com>
Subject: test
From: Mr. Furious <mr.furious@example.com>
To: The Sphinx <the.sphinx@example.com>
Cc: The Spleen <the.spleen@example.com>
Content-Type: text/plain; charset=ISO-8859-1
Reply-To: blue.raja@example.com

This is a test.

My special power is that I'm terriby mysterious.)

  HEADER = %(MIME-Version: 1.0
Received: by 10.236.95.44 with HTTP; Thu, 22 Sep 2011 18:21:36 -0700 (PDT)
Date: Thu, 22 Sep 2011 21:21:36 -0400
Delivered-To: the.sphinx@example.com
Message-ID: <CACy8cYDTK0_ra68Wb_X99doKQDErZKNn+8VOVahV6_fdbTdq7A@mail.gmail.com>
Subject: test
From: Mr. Furious <mr.furious@example.com>
To: The Sphinx <the.sphinx@example.com>
Cc: The Spleen <the.spleen@example.com>
Content-Type: text/plain; charset=ISO-8859-1
Reply-To: blue.raja@example.com)

  BODY = %(This is a test.

My special power is that I'm terriby mysterious.)

  context 'initialize email object' do
    setup do
      @email = GangstaMail::Email.new(RAW_EMAIL)
    end

    should 'return original raw email' do
      assert_equal(@email.raw_email, RAW_EMAIL)
    end
  
    should 'return header' do
      assert_equal(@email.header, HEADER)
    end
  
    should 'return body' do
      assert_equal(@email.body, BODY)
    end
    
    should 'return from field' do
      assert_equal(@email.from, 'Mr. Furious <mr.furious@example.com>')
    end
    
    should 'return date' do
      assert_equal(@email.date, 'Thu, 22 Sep 2011 21:21:36 -0400')
    end
    
    should 'return to' do
      assert_equal(@email.to, 'The Sphinx <the.sphinx@example.com>')
    end
    
    should 'return subject' do
      assert_equal(@email.subject, 'test')
    end
    
    should 'return cc' do
      assert_equal(@email.cc, 'The Spleen <the.spleen@example.com>')
    end
    
    should 'return content_type' do
      assert_equal(@email.content_type, 'text/plain; charset=ISO-8859-1')
    end
        
    should 'return reply_to' do
      assert_equal(@email.reply_to, 'blue.raja@example.com')
    end
  end
end