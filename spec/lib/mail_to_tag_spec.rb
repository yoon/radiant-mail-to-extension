require File.dirname(__FILE__) + '/../spec_helper'

describe MailToTag do
  before(:each) do
    @mail_to_tag = MailToTag.new
  end

  it "should be valid" do
    @mail_to_tag.should be_valid
  end
end
