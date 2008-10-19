require File.dirname(__FILE__) + '/../spec_helper'

describe MailToTag do
  scenario :users_and_pages
  describe "<r:mail_to>" do
    it "should render an error if the configuration is invalid" do
       pages(:home).should render("<r:mail_to />").as("Please provide an `email' attribute for the `mail_to' tag.")
    end

    it "should render a simple mailto: link if the configuration is valid" do
      pages(:mail_form).should render('<r:mail_to email="me@domain.com" />').as('<a href="mailto:me@domain.com">me@domain.com</a>')
    end
    
    
    it "should validate encoding type" do
       pages(:home).should render('<r:mail_to email="me@domain.com" encode="rot13" />').as("Encoding must be one of 'javascript' or 'hex'.")
    end
    
    it "should render a hex-encoded mailto: link" do
      pages(:mail_form).should render('<r:mail_to email="me@domain.com" encode="hex" />').as('<a href="&#109;&#97;&#105;&#108;&#116;&#111;&#58;%6d%65@%64%6f%6d%61%69%6e.%63%6f%6d">me@domain.com</a>')
    end
    
    it "should use the name attribute when provided" do
      pages(:mail_form).should render('<r:mail_to email="me@domain.com" name="My email" encode="hex" />').as('<a href="&#109;&#97;&#105;&#108;&#116;&#111;&#58;%6d%65@%64%6f%6d%61%69%6e.%63%6f%6d">My email</a>')
    end

    it "should encode the name when requested" do
      pages(:mail_form).should render('<r:mail_to email="me@domain.com" encode="hex" name="My email" encode_name="true" />').as('<a href="&#109;&#97;&#105;&#108;&#116;&#111;&#58;%6d%65@%64%6f%6d%61%69%6e.%63%6f%6d">&#109;&#101;&#64;&#100;&#111;&#109;&#97;&#105;&#110;&#46;&#99;&#111;&#109;</a>')
    end
    
    it "should render a javascript-encoded mailto: link" do
      pages(:mail_form).should render('<r:mail_to email="me@domain.com" name="My email" encode="javascript" />').as('<script type="text/javascript">eval(unescape(\'%64%6f%63%75%6d%65%6e%74%2e%77%72%69%74%65%28%27%3c%61%20%68%72%65%66%3d%22%6d%61%69%6c%74%6f%3a%6d%65%40%64%6f%6d%61%69%6e%2e%63%6f%6d%22%3e%4d%79%20%65%6d%61%69%6c%3c%2f%61%3e%27%29%3b\'))</script>')
    end
    
    it "should support other options of the mail_to method" do
      pages(:mail_form).should render('<r:mail_to email="me@domain.com" name="My email" cc="ccaddress@domain.com" subject="This is an example email" />').as('<a href="mailto:me@domain.com?cc=ccaddress%40domain.com&amp;subject=This%20is%20an%20example%20email">My email</a>')
    end

  end
end