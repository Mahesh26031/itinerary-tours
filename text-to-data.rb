require 'openai'


def input_data

   text="Day 1: Arrive in Jaipur and visit Amber Fort, City Palace and Jantar Mantar.
   
   Day 2: Explore Jaipur further, including Hawa Mahal, Jal Mahal and Birla Temple.
   
   Day 3: Drive to Jodhpur and visit Mehrangarh Fort and Jaswant Thada Memorial.
   
   Day 4: Drive to Udaipur and visit the City Palace and Jagdish Temple.
   
   Day 5: Take a boat ride on Lake Pichola and visit Jagmandir Island Palace.
   
   Day 6: Drive to Jaisalmer and explore the Golden Fort, Patwon Ki Haveli and Gadisar Lake.
   
   Day 7: Drive back to Jaipur for your departure flight."

end   
   


def get_response(text,client,prompt)

    return client.completions(
    engine: "text-davinci-002",
    prompt: prompt,
    max_tokens: 1024,
    n: 1,
    stop: "",
    temperature: 0,
  )

end    


def get_location(text,client)

  prompt = "Extract city from: #{text}"
  response = get_response(text,client,prompt)
  location = response.choices.first.text.strip
  return location

end

# def get_activity(text,client)
 
#    prompt = "extract the activity from this text: #{text}"
#   response = get_response(text,client,prompt)
#   activity = response.choices.first.text.strip
#   return activity

# end  


def get_day(text)

    day = text.scan(/\d+/).first
    return day

end


def get_destination_from_each_line(destinations,text,client)

    text.each do |day|

        location = get_location(day,client)
        day_number = get_day(day)
        destinations.push([location,day_number])           

    end

end    

# def get_data_from_each_line(destinations,text,client)

#   text.each do |day|

#       activity = get_activity(day,client)
#       day_number = get_day(day)
#       destinations.push([activity,day_number])            


#   end

# end    


def print_destinations(destinations)

    puts destinations.map { |x| x.join(' ') }

end    

def get_days_from_text(text)
  days = text.split("Day")
end  



client = OpenAI::Client.new(api_key: "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")
text = input_data
days = get_days_from_text(text)
days.shift

destinations =[[]]

get_destination_from_each_line(destinations,days,client)
print_destinations(destinations)
  






