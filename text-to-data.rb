require 'openai'


def input_data

    text = "Day 1: Arrive in Jaipur and visit Amber Fort, City Palace and Jantar Mantar
            mahesh
            Day 2: Explore Jaipur further, including Hawa Mahal, Jal Mahal and Birla Temple.
            Day 3: Drive to Jodhpur and visit Mehrangarh Fort and Jaswant Thada Memorial.
            Day 4: Drive to Udaipur and visit the City Palace and Jagdish Temple.
            Day 5: Take a boat ride on Lake Pichola and visit Jagmandir Island Palace.
            Day 6: Drive to Jaisalmer and explore the Golden Fort, Patwon Ki Haveli and Gadisar Lake.
            Day 7: Drive back to Jaipur for your departure flight."
end            


def remove_spaces(text)

    text = text.gsub(/^$\n/,'')

end    

def get_response(text,client)

    return client.completions(
    engine: "text-davinci-002",
    prompt: "Extract city from: #{text}",
    max_tokens: 1024,
    n: 1,
    stop: "",
    temperature: 0,
  )

end    


def get_location(text,client)

  response = get_response(text,client)
  location = response.choices.first.text.strip
  return location

end


def get_day(text)

    day = text.scan(/\d+/).first
    return day

end


def count_spaces(text)
    
  return text.count(" ")

end




def get_data_from_each_line(destinations,text,client)

    text.each_line do |line|

        location = get_location(line,client)
        spaces = count_spaces(location)
        day = get_day(line)

        if !day 
            next
        end    

        if(spaces == 0) 

          destinations.push([location,day])            

        else

          destinations.push([destinations[-1][0],day])  
        end

    end

end    


def print_destinations(destinations)

    puts destinations.map { |x| x.join(' ') }

end    



client = OpenAI::Client.new(api_key: "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")
text = input_data
text = remove_spaces(text)
destinations =[[]]

get_data_from_each_line(destinations,text,client)
print_destinations(destinations)
  






