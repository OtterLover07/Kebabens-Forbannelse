

#global variabel
$plats = "järntorget"
$inventory = []
$history = []
$life = 100
$hunger = 100
$loop = 0


def init()
   #läs in från fil
   f = File.readlines("savefile.txt")
   $inventory = f[1].split#???
   $history = f[2].split#???
   #o.s.v
end
#TODO: SKRIV KODEN ACTUALLY
#FÅ HANDLINGSTRÄDET ATT FUNKA

def järntorget()
   puts "vart vill du gå?"
   user_input = gets.chomp
   while user_input != "quit"
       if user_input == "gå kebabvagnen"
           $plats = "kebabvagnen"
           return #OBS VIKTIGT
       elsif user_input == "prata lisebergskaninen"
           $plats = "lisebergskaninen"
           return #OBS VIKTIGT
       #elsif ??????
       else
           puts "ogiltigt val"
       end
       puts "vart vill du gå?"
       user_input = gets.chomp
   end
   return
end


def main()
   init()
   while $life > 0 #&& ????
       if $plats == "skogen"
           skogen()
       #elsif ?????
       #elsif ?????
       #elsif ?????
       #elsif ?????
       #elsif ?????
       else
           $plats == "okänt"
       end
   end
end


main()

