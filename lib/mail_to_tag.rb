module MailToTag
  include Radiant::Taggable
  
  class TagError < StandardError; end

  tag "mail_to" do |tag|
    attr = tag.attr.symbolize_keys
    raise TagError.new("Please provide an `email' attribute for the `mail_to' tag.") unless attr.has_key?(:email)
    link_text = (tag.expand.blank? ? nil : tag.expand) || attr[:name] || attr[:email]
    
    in_context ViewContext do
      mail_to(attr[:email], link_text, :encode => :javascript)
    end
  end
  
  private
  # Much help on context from http://svn.radiantcms.org/radiant/trunk/extensions/forms/lib/forms/tags.rb
  def in_context(context_type, &block)
    context_type.new.instance_eval(&block)
  end
end

class ViewContext
  include ActionView::Helpers::TagHelper
  include ActionView::Helpers::UrlHelper
end