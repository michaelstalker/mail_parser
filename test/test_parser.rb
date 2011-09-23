require 'test/unit'
require 'shoulda'
require 'redgreen'
require_relative '../lib/gangsta_mail/parser'

class TestParser < Test::Unit::TestCase
  
  EMAIL = %(MIME-Version: 1.0
Received: by 10.236.95.44 with HTTP; Thu, 22 Sep 2011 18:21:36 -0700 (PDT)
Date: Thu, 22 Sep 2011 21:21:36 -0400
Delivered-To: mr.furious@example.com
Message-ID: <CACy8cYDTK0_ra68Wb_X99doKQDErZKNn+8VOVahV6_fdbTdq7A@mail.gmail.com>
Subject: test
From: Mr. Furious <mr.furious@example.com>
To: The Sphinx <the.sphinx@example.com>
Content-Type: text/plain; charset=ISO-8859-1

This is a test.

My special power is that I'm terriby mysterious.)
  
  should 'fetch header from email' do
    original_header = %(MIME-Version: 1.0
Received: by 10.236.95.44 with HTTP; Thu, 22 Sep 2011 18:21:36 -0700 (PDT)
Date: Thu, 22 Sep 2011 21:21:36 -0400
Delivered-To: mr.furious@example.com
Message-ID: <CACy8cYDTK0_ra68Wb_X99doKQDErZKNn+8VOVahV6_fdbTdq7A@mail.gmail.com>
Subject: test
From: Mr. Furious <mr.furious@example.com>
To: The Sphinx <the.sphinx@example.com>
Content-Type: text/plain; charset=ISO-8859-1)

    fetched_header = GangstaMail::Parser.fetch_header EMAIL
    assert_equal(fetched_header, original_header)
  end

  should 'fetch body from email' do
    original_body = %(This is a test.

My special power is that I'm terriby mysterious.)
    
    fetched_body = GangstaMail::Parser.fetch_body EMAIL
    assert_equal(fetched_body, original_body)
  end
  
  should 'parse header and return a hash of fields' do
    header = %(MIME-Version: 1.0
Received: by 10.236.95.44 with HTTP; Thu, 22 Sep 2011 18:21:36 -0700 (PDT)
Date: Thu, 22 Sep 2011 21:21:36 -0400
Delivered-To: mr.furious@example.com
Message-ID: <CACy8cYDTK0_ra68Wb_X99doKQDErZKNn+8VOVahV6_fdbTdq7A@mail.example.com>
Subject: test
From: Mr. Furious <mr.furious@example.com>
To: The Sphinx <the.sphinx@example.com>
Content-Type: text/plain; charset=ISO-8859-1)
    original_fields = { :'mime-version' => '1.0',
               :received => 'by 10.236.95.44 with HTTP; Thu, 22 Sep 2011 18:21:36 -0700 (PDT)',
               :date => 'Thu, 22 Sep 2011 21:21:36 -0400',
               :'delivered-to' => 'mr.furious@example.com',
               :'message-id' => '<CACy8cYDTK0_ra68Wb_X99doKQDErZKNn+8VOVahV6_fdbTdq7A@mail.example.com>',
               :subject => 'test',
               :from => 'Mr. Furious <mr.furious@example.com>',
               :to => 'The Sphinx <the.sphinx@example.com>',
               :'content-type' => 'text/plain; charset=ISO-8859-1' }
    fetched_fields = GangstaMail::Parser.parse_header header
    assert_equal(fetched_fields, original_fields)
  end
end