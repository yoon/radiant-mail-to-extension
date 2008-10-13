Mail To
-------

MailTo is a [Radiant CMS][1] extension that hides e-mails from robots. It is a wrapper for the [Rails mail_to method][2] and supports all of the same options provided by that method.

`mail_to`
---------

The `mail_to` tag obfuscates an as a block of javascript. For example, 

	<r:mail_to email="joe@example.com" />
	
is turned into

	<a href="&#109;&#97;&#105;&#108;&#116;&#111;&#58;%6a%6f%65@%65%78%61%6d%70%6c%65.%63%6f%6d">joe@example.com</a>
	
and will be displayed as a human-readable link.

Additional Options
------------------

From the [Rails documentation][2]:

> Creates a mailto link tag to the specified `email_address`, which is also used as the name of the link unless `name` is specified. Additional HTML attributes for the link can be passed in `html_options`.
> 
> `mail_to` has several methods for hindering email harvesters and customizing the email itself by passing special keys to `html_options`.
> 
> Options
> 
> * `:encode` - This key will accept the strings "javascript" or "hex". Passing "javascript" will dynamically create and encode the `mailto:` link then eval it into the DOM of the page. This method will not show the link on the page if the user has JavaScript disabled. Passing "hex" will hex encode the `email_address` before outputting the `mailto:` link.
> * `:replace_at` - When the link name isn‘t provided, the `email_address` is used for the link label. You can use this option to obfuscate the `email_address` by substituting the @ sign with the string given as the value.
> * `:replace_dot` - When the link name isn‘t provided, the `email_address` is used for the link label. You can use this option to obfuscate the email_address by substituting the . in the email with the string given as the value.
> * `:subject` - Preset the subject line of the email.
> * `:body` - Preset the body of the email.
> * `:cc` - Carbon Copy addition recipients on the email.
> * `:bcc` - Blind Carbon Copy additional recipients on the email.

Examples
--------

  &lt;r:mail_to email="me@domain.com" /&gt;
  # => &lt;a href="mailto:me@domain.com"&gt;me@domain.com&lt;/a&gt;

  &lt;r:mail_to email="me@domain.com" name="My email" encode="javascript" /&gt;
  # => &lt;script type="text/javascript"&gt;eval(unescape('%64%6f%63...%6d%65%6e'))&lt;/script&gt;

  &lt;r:mail_to email="me@domain.com" encode="hex" encode_name="true" /&gt;
  # => &lt;a href="&#109;&#97;&#105;&#108;&#116;&#111;&#58;%6d%65@%64%6f%6d%61%69%6e.%63%6f%6d"&gt;&#109;&#101;&#64;&#100;&#111;&#109;&#97;&#105;&#110;&#46;&#99;&#111;&#109;&lt;/a&gt;

  &lt;r:mail_to email="me@domain.com" replace_at="_at_" replace_dot="_dot_" class="email" /&gt;
  # => &lt;a href="mailto:me@domain.com" class="email"&gt;me_at_domain_dot_com&lt;/a&gt;

  &lt;r:mail_to email="me@domain.com" name="My email" cc="ccaddress@domain.com" subject="This is an example email" /&gt;
  # => &lt;a href="mailto:me@domain.com?cc=ccaddress@domain.com&subject=This%20is%20an%20example%20email"&gt;My email&lt;/a&gt;


Acknowledgments
---------------

[1]: http://radiantcms.org/
[2]: http://rails.rubyonrails.com/classes/ActionView/Helpers/UrlHelper.html#M001606
