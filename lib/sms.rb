# -*- coding: utf-8 -*-
class SMS
  def self.send_sms(phone,message)
    raise "Посылаю только на 79023270019" unless phone.to_s=="79023270019"
    #       my $converter = Text::Iconv->new("koi8-r", "cp1251");
    # my $message=uri_escape($converter->convert($message));
    message=URI.escape(Iconv.iconv('cp1251','utf-8',message).to_s)
    
    url = "http://www.shgsm.ru/esme/transmitter.php?id=#{SHGSM_KEY}&daddr=#{phone}&msg=#{message}";
    
    response = HTTParty.get(url)
    #    puts response.body, response.code, response.message, response.headers.inspect
    
    response.body.length>100 ? true : false
    
  end
end
