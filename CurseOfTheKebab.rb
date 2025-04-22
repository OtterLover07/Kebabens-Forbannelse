puts "\e[H\e[2J"
puts "Loading..."

class Item
    @held = false
    @used = false

    def initialize(name, location, usable_with)
        @name = name
        @location = location
        @usable_with = usable_with
        $items << name
    end

    def name
        return @name
    end

    def location
        return @loaction
    end

    def pick_up
        if $plats != @location || @used
            puts "Det finns ingen " + name + " här."
        elsif @held
            puts "Du har redan " + name + "."
        else
            @held = true
            puts "Du plockar upp " + name + "."
        end
        return false
    end

    def use(target)
        if !@held
            puts "Du har inte " + @name + "."
        elsif target == @usable_with || @usable_with.include?(target)
            @held = false
            @used = true
            return true
        else
            puts "Du försöker använda " + @name + " med " + target + ", men det funkar inte."
        end
        return false
    end
end

#global variabel
$items = []
$plats = "järntorget"
$life = 100
$hunger = 100
$money = 15


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
   puts "Vad vill du göra?"
   user_input = gets.chomp
   while user_input != "quit"
       if user_input == "gå kebabvagnen"
           $plats = "kebabvagnen"
           puts "Du går till kebabvagnen."
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

####################### FIXA ALLMÄN KOD - SLIPPA HARDCODA ##########################
def default()
    while true
        puts "Vad vill du göra?"
        puts ""
        user_input = gets.chomp.split
        while user_input[0] != "quit"
            if user_input[0] == "ta"
                $items.const_get(user_input[1])
                
            elsif user_input[0] == "köp" && user_input[1] == "kebab"
                
            elsif user_input[0] == "använd"
               
            elsif user_input[0] == "poor"
                
            else
                puts "ogiltig handling"
            end
            puts ""
            puts "Vad vill du göra?"
            puts ""
            user_input = gets.chomp.split
        end
        exit
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


##################TESTKOD NEDANFÖR############################
baby = Item.new("baby", "järntorget", "fönster")
kebab = Item.new("kebab", "järntorget", ["fönster","mig"])

puts "Loading complete!"
puts "\e[H\e[2J"

while true
    puts "Vad vill du göra?"
    puts ""
    user_input = gets.chomp.split
    while user_input[0] != "quit"
        if user_input[0] == "ta"
            if user_input[1] == "baby"
                baby.pick_up
            elsif user_input[1] == "kebab"
                kebab.pick_up
            end
        elsif user_input[0] == "köp" && user_input[1] == "kebab"
            if $money >= 5
                $money -= 5
                kebab.pick_up
            else
                puts "Du har inte råd att köpa kebab."
            end
        elsif user_input[0] == "använd"
            if user_input[1] == "baby"
                if baby.use(user_input[2])
                    puts "NooOooOo dOn'T tHrOw ThA bAbY!"
                end
            elsif user_input[1] == "kebab"
                if kebab.use(user_input[2])
                    puts "Du använder kebaben. Du är nu död. Grattis."
                end
            end
        elsif user_input[0] == "poor"
            $money = 0
            puts "Du är nu fattig."
        else
            puts "ogiltig handling"
        end
        puts ""
        puts "Vad vill du göra?"
        puts ""
        user_input = gets.chomp.split
    end
    exit
end

