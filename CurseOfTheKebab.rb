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

    def used?
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
$location = "jarntorget"
$money = 15
$harBaby
$kastatBaby = false
TextSpeed = 1

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
        $items << Item.new("boltcutters", "boltcutterStore", "grind", "framfor_bion")
    end
end

def action()
    while true
        sleep TextSpeed
        puts ""
        puts "Vad vill du göra?"
        puts ""
        user_input = gets.chomp.downcase.split
        puts ""
        while user_input[0] != "quit"
            if user_input[0] == "hjälp"
                puts ""
                puts "Giltiga kommandon:"
                puts "  - 'kolla'"
                puts "  - 'kolla x'"
                puts "  - 'gå x'"
                puts "  - 'ta x'"
                puts "  - 'använd x y'"
                puts "  - 'öppna x'"
                puts "  - 'kasta x'"
                puts "  - 'hjälp'"
                puts "  - 'quit'"
                
            elsif user_input[0] == "kolla"
                if user_input[1] != nil
                    return "kolla " + user_input[1]
                else
                    return "kolla"
                end
            elsif user_input[0] == "gå"
                return "gå " + user_input[1]
            elsif user_input[0] == "ta"
                item = getItem(user_input[1])
                if item == nil
                    puts "Det finns ingen " + user_input[1] + " här."
                else
                    item.pick_up
                end
                return false
            elsif user_input[0] == "använd"
                item = getItem(user_input[1])
                if item != nil
                    if item.use(user_input[2])
                        return "använd " + user_input[1]
                    end
                end
                return false
            elsif user_input[0] == "öppna"
                return "öppna " + user_input[1]
            elsif user_input[0] == "kasta"
                item = getItem(user_input[1])
                if user_input[1] == "baby" && $harBaby
                    return "kasta baby"
                elsif item != nil && !item.used?
                    puts "Det är nog inte den bästa idén att slänga iväg den..."
                else
                    puts "Du har ingen " + user_input[1] + "."
                end
            else
                puts "Ogiltig handling, försök igen."
            end
            puts ""
            sleep TextSpeed
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
    sleep TextSpeed
end

def jarntorget()
    while true
        action = action() #ex.=> "kolla dörrmatta"
        if action == "placeholder"
            
        elsif action == "gå långgatan"
            puts "Du går fram till långgatan."
            $location = "långgatan"
            return nil
        elsif action == "gå spårvagn"
            puts "Du går till spårvagnen. Den kommer om 20min. Whelp, dags att vänta."
            sleep TextSpeed
            puts "[20min later]"
            sleep TextSpeed
            puts "Du hoppar på. Vagnen är tom förutom föraren. Blir avkickad vid stigbergstorget för att ha plankat."
            $location = "stigbergstorget"
            return nil
        elsif action == "gå tillbaka"
            puts "Det finns ingen annan plats att gå."
        elsif action == "kasta baby"
            puts "Babyn faller till marken med en duns, och den börjar gråta."
            sleep TextSpeed
            puts "Du är i samma situation som innan, men nu med en gråtande baby. Grattis."
            $kastatBaby = true
        elsif action == "kolla"
            return nil
        end
    end
end

def langgatan()
    while true
        action = action() #ex.=> "kolla dörrmatta"
        if action == "placeholder"

        elsif action == "placeholder"
            
            
        elsif action == "gå tillbaka"
            puts "Du går tillbaka till Järntorget."
            $plats == "framför_bion"
            return nil
        elsif action == "kasta baby"
            puts "Babyn faller till marken med en duns, och den börjar gråta."
            puts "Du är i samma situation som innan, men nu med en gråtande baby. Grattis."
            $kastatBaby = true
        elsif action == "kolla"
            return nil
        end
    end
end

def boltcutterStore()
    while true
        action = action() #ex.=> "kolla dörrmatta"
        if action == "placeholder"

        elsif action == "köp boltcutters" # ROBIN SKRIV NÄR DU KAN PLS THANK UU <3
            
        elsif action == "gå tillbaka"
            puts "Du går tillbaka till Långgatan."
            $plats == "framför_bion"
            return nil
        elsif action == "kasta baby"
            puts "Babyn faller till marken med en duns, och den börjar gråta."
            puts "Du är i samma situation som innan, men nu med en gråtande baby. Grattis."
            $kastatBaby = true
        elsif action == "kolla"
            return nil
        end
    end
end

def stigbergstorget()
    while true
        action = action() #ex.=> "kolla dörrmatta"
        if action == "placeholder"

        elsif action == "gå framför_bion"
            puts "Du går fram till bion. De verkar ha stängt."
            $location = "framfor_bion"
            return nil
        elsif action == "gå tillbaka"
            puts "Du väntar in nästa 3:a och åker tillbaka till Järntorget."
            $plats == "järntorget"
            return nil
        elsif action == "kasta baby"
            puts "Babyn faller till marken med en duns, och den börjar gråta."
            sleep TextSpeed
            puts "Du är i samma situation som innan, men nu med en gråtande baby. Grattis."
            $kastatBaby = true
        elsif action == "kolla"
            return nil
        end
    end
end

def framfor_bion()
    puts "Du står framför en midre bio"
    sleep TextSpeed
    puts "Framför dig har du en dörr in i byggnaden, och vid sidan en grind till baksidan."
    while true
        action = action() #ex.=> "kolla dörrmatta"
        if action == "placeholder"
            
        elsif action == "använd boltcutters"
            puts "låset faller ner på marken med ett kling, och grinden öppnas."
        elsif action == "gå grind"
            if getItem(boltcutters).used?
                puts "Du går in bakom bion."
                $location = "bakom_bion"
                return nil
            else
                puts "Du går in i grinden. Babyn skrattar lite."
            end
        elsif action == "gå tillbaka"
            puts "Du går tillbaka till Stigbergstorget."
            $plats == "stigbergstorget"
            return nil
        elsif action == "kasta baby"
            puts "Babyn faller till marken med en duns, och den börjar gråta."
            sleep TextSpeed
            puts "Du är i samma situation som innan, men nu med en gråtande baby. Grattis."
            $kastatBaby = true
        elsif action == "kolla"
            return nil
        end
    end
end

def bakom_bion()
    puts ""
    puts "Du är nu bakom bion. Du ser en röten bakdörr i skenet av lampan över den."
    sleep TextSpeed
    puts "Framför dörren ser du en liten matta med ordet 'Välkommen' i kursiv stil."
    while true
        action = action() #ex.=> "kolla dörrmatta"
        if action == "kolla dörrmatta"
            puts "Du tittar under dörrmattan och ser en nyckel. Ksk bör prova den på dörren."
        elsif action == "öppna dörr" || action == "gå dörr"
            puts "Dörren är låst."
        elsif action == "använd nyckel"
            puts "Du prövar nyckeln i hålet, och hör hur låset låter ifrån sig ett klick."
            sleep TextSpeed
            puts "Du puttar lite lätt på dörren, och dörren ger vika. Du går in i bion."
            puts ""
            ending()
        elsif action == "gå tillbaka"
            puts "Du går tillbaka till bions framsida."
            $plats == "framfor_bion"
            return nil
        elsif action == "kasta baby"
            puts "Babyn faller till marken med en duns, och den börjar gråta."
            sleep TextSpeed
            puts "Du är i samma situation som innan, men nu med en gråtande baby. Grattis."
            $kastatBaby = true
        elsif action == "kolla"
            return nil
        end
    end
end

def ending()
    puts "Du vaknar upp på toaletten på bion, extremt hangover."
    sleep TextSpeed
    puts "Du kollar telefonen, det är morgon. Du går ut och njutar av dagen, med en lätt bismak av kebab."
    if $kastatBaby
        puts ""
        sleep TextSpeed
        puts "Sen blir du arresterad för våld mot barn. Rätt åt dig!"
    end
    puts ""
    sleep TextSpeed
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
        if $location == "jarntorget"
            jarntorget()
        elsif $location == "langgatan"
            langgatan()
        elsif $location == "boltcutterStore"
            boltcutterStore
        elsif $location == "stigbergstorget"
            stigbergstorget()
        elsif $location == "framfor_bion"
            framfor_bion()
        elsif $location == "bakom_bion"
            bakom_bion()
        else
            raise "ERROR: Location Not Found"
        end
    end
end


##################TESTKOD NEDANFÖR##########################

main()
