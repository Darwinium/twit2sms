require  File.dirname(__FILE__) + '/../config/environment'

require 'twitter'
require 'pp'


class TwitBot
  def self.update_status
    #while (0 < 1)
      f_count = Follow.count      
      pp "Count users: " + f_count.to_s
      
      for i in 1..f_count do
        follow = Follow.find(i)
        pp "Follow id: " + follow.id.to_s
        
        if (User.find(follow.user_id).phone_confirmed)
          user_status = Twitter.user(follow.twitter)
          
          # если такой твит уже отслеживается  
          if (Twit.find_by_id(follow.id) != nil)
            pp Twit.find_by_id(follow.id).id
            
            breakpoint
            
            if (very_date(twit.created_at, Twit.find(follow.id).sent_at))
              # то ничего не делаем
            else
              # иначе, обновляем твит
              pp "update twit"
              update_twit(user_status, follow.id)
            end
            
          else
            pp "NO"
          end        
        else
          #код у юзера не подтверждён
        end
      end
    #end
  end
  
  def self.very_date(twit_sent, twit_create)
    
    pp twit_sent
    pp twit_create
    
    if (twit_sent == twit_create)
      return false
    else
      return true
    end
  end
  
  def self.create_twit(twit_json, follow_id)
    twit = Twit.new
    twit.follow_id = follow_id
    twit.message = twit_json.status.text
    twit.message_time = twit_json.status.created_at
    twit.save
  end
  
  def self.update_twit(twit_json, follow_id)
    twit = Twit.find(follow_id)
    twit.follow_id = follow_id
    twit.message = twit_json.status.text
    twit.message_time = twit_json.status.created_at
    twit.update
  end  
end

twit = TwitBot.update_status