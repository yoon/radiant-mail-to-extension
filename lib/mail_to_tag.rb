module MailToTag
  include Radiant::Taggable
  
  class TagError < StandardError; end

  desc %{
  Generates a <code>mailto:</code> link. If <code>encode</code> is one of "javascript" or "hex", the email address will be obfuscated.
  This tag accepts as attributes any options that the Rails <code>mail_to</code> method accepts. HTML attributes for the link can be used as well. See the
  <a href="http://rails.rubyonrails.com/classes/ActionView/Helpers/UrlHelper.html#M001606">Rails documentation</a> for more information.
  This tags add the ability to encode the link text as well, by setting <code>encode_name</code> to <code>true</code>.

  Usage:
  <pre><code> <r:mail_to email="joe@example.com" [name="Joe User"] [encode_name="false|true"] [encode="javascript|hex"] /></code></pre>
  
  Can also be used as a block:
  <pre><code> <r:mail_to email="joe@example.com">Joe User</r:mail_to></code></pre>}
  tag "mail_to" do |tag|
    attr = tag.attr.symbolize_keys
    attr[:encode_name] = false if attr[:encode_name] && attr[:encode_name].downcase != 'true'
    raise TagError.new("Please provide an `email' attribute for the `mail_to' tag.") unless attr.has_key?(:email)
    raise TagError.new("Encoding must be one of 'javascript' or 'hex'.") unless (attr[:encode].nil? || %w[javascript hex].include?(attr[:encode]))
    
    link_text = (tag.expand.blank? ? nil : tag.expand) || attr.delete(:name) || attr[:email]
    if attr.delete(:encode_name)
      link_text_encoded = ''
      link_text.unpack('U'*link_text.length).each do |c|
        link_text_encoded << "&#" << c.to_s << ";"
      end
      link_text = link_text_encoded
    end
    
    email = attr.delete(:email)
    
    in_context ViewContext do
      mail_to(email, link_text, attr)
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