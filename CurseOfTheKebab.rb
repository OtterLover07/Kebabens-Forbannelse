puts "\e[H\e[2J"
puts "Loading..."

class Item
    @held = false
    @used = false

    def initialize(name, location, usable_with, useLocation)
        @name = name
        @location = location
        @usable_with = usable_with
        @useLocation = useLocation
    end

    def name
        return @name
    end

    def location
        return @location
    end

    def used
        return @used
    end

    def pick_up
        if $location != @location || @used
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
        elsif ($location == @useLocation || @useLocation.include?($location)) && (target == @usable_with || @usable_with.include?(target))
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
$location = "bakom_bion"
$money = 15
$harBaby
$kastatBaby = false

def getItem(query)
    i = 0
    while i < $items.length
        if $items[i].name == query
            return $items[i]
        end
    end
    return nil
end

def init()
    if File.exist?("savefile.txt")
        #läs in från fil
        f = File.readlines("savefile.txt")
        $items = f[1].split#???
        $location = f[2]
        #o.s.v
    else
        # $items << Item.new(name, location, usable_with, useLocation)
        $items << Item.new("nyckel", "bakom_bion", "dörr", "bakom_bion")
        $items << Item.new("baby", "boltcutterStore", ["dörr", "fönster"], ["bakom_bion", "boltcutterStore"])
    end
end

def action()
    while true
        puts ""
        puts ""
        puts "Vad vill du göra?"
        puts ""
        user_input = gets.chomp.split
        while user_input[0] != "quit"
            if user_input[0] == "hjälp"
                puts ""
                puts "Giltiga kommandon:"
                puts "  - 'kolla x'"
                puts "  - 'gå x'"
                puts "  - 'ta x'"
                puts "  - 'använd x y'"
                puts "  - 'kasta x'"
                puts "  - 'hjälp'"
                puts "  - 'quit'"
                
            elsif user_input[0] == "ta"
                item = getItem(user_input[1])
                if item == nil
                    puts "Det finns ingen " + user_input[1] + " här."
                else
                    item.pick_up
                end
                return false
            elsif user_input[0] == "gå"
                return "gå " + user_input[1]
                
            elsif user_input[0] == "använd"
                item = getItem(user_input[1])
                if item != nil
                    if item.use(user_input[2])
                        return "använd " + user_input[1]
                    end
                end
                return false
               
            elsif user_input[0] == "kolla"
                return "kolla " + user_input[1]

            elsif user_input[0] == "kasta"
                item = getItem(user_input[1])
                if user_input[1] == "baby" && $harBaby
                    return "kasta baby"
                elsif item != nil && !item.used
                    puts "Det är nog inte den bästa idén att slänga iväg den..."
                else
                    puts "Du har ingen " + user_input[1] + "."
                end
            else
                puts "Ogiltig handling, försök igen."
            end
            puts ""
            puts "Vad vill du göra?"
            puts ""
            user_input = gets.chomp.split
        end
        exit
    end
end

def beginning()
    puts "And the adventure begins!"
    puts ""
end

def framfor_bion()
    puts "Du står framför en midre bio"
end

def bakom_bion()
    puts ""
    puts "Du är nu bakom bion. Du ser en röten bakdörr i skenet av lampan över den."
    puts "Framför dörren ser du en liten matta med ordet 'Välkommen' i kursiv stil."
    while true
        action = action() #ex.=> "kolla dörrmatta"
        if action == "kolla dörrmatta"
            puts "Du tittar under dörrmattan och ser en nyckel. Ksk bör prova den på dörren."
        elsif action == "kasta baby"
            puts "Babyn faller till marken med en duns, och börjar gråta."
            puts "Du är i samma situation som innan, men med en gråtande baby. Gratulationer."
            $kastatBaby = true
        elsif action == "öppna dörr"
            puts "Dörren är låst."
        elsif action == "gå tillbaka"
            $plats == "framför_bion"
            return nil
        elsif action == "använd nyckel"
            puts "Du prövar nyckeln i hålet, och hör hur låset låter ifrån sig ett klick."
            puts "Du puttar lite lätt på dörren, och dörren ger vika. Du går in i bion."
            puts ""
            ending()
        end
    end
end

def ending()
    puts "Du vaknar upp på toaletten på bion, extremt hangover."
    puts "Du kollar telefonen, det är morgon. Du går ut och njutar av dagen, med en lätt bismak av kebab."
    if $kastatBaby
        puts ""
        puts "Sen blir du arresterad för våld mot barn. Rätt åt dig!"
    end
    puts ""
    puts "[tryck enter för att avsluta]"
    gets
    exit
end

def main()
    init()

    puts "Loading complete!"
    puts "\e[H\e[2J"
    beginning()
    while true
        if $location == "bakom_bion"
            bakom_bion()
        elsif $location == "framfor_bion"
            framfor_bion()
        elsif $location == ""
        elsif $location == ""       
        else
            raise "ERROR: Location Not Found"
        end
    end
end


##################TESTKOD NEDANFÖR##########################

main()
