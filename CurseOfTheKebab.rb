puts "\e[H\e[2J"
puts "Loading..."

class Item
    def initialize(name, location, usable_with, useLocation)
        @name = name
        @location = location
        @usable_with = usable_with
        @useLocation = useLocation
        @held = false
        @used = false
    end

    def inspect
        output = ""
        output << @name.to_s + ";;"
        output << @location.to_s + ";;"
        output << @usable_with.to_s + ";;"
        output << @useLocation.to_s + ";;"
        output << @held.to_s + ";;"
        output << @used.to_s + ";;"
        return output
    end

    def name
        return @name
    end

    def location
        return @location
    end

    def held?
        return @held
    end
    
    def used?
        return @used
    end

    def setBools(held, used)
        @held = held
        @used = used
    end

    def pick_up
        if $location != @location || @used
            puts "Det finns ingen " + name + " här."
        elsif @held
            puts "Du har redan " + name + "."
        else
            @held = true
            puts "Du har nu " + name + "."
            return true
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

def itemDebug()
    i = 0
    while i < $items.length
        puts $items[i].inspect
        i += 1
    end
end

#global variabel
$items = []
$location = "jarntorget"
$harBaby = false
$kastatBaby = false
$buyFails = 0
TextSpeed = 0

def getItem(query)
    i = 0
    while i < $items.length
        if $items[i].name == query
            return $items[i]
        end
        i += 1
    end
    return nil
end

def init()
    if File.exist?("savefile.txt")
        f = File.readlines("savefile.txt")
        i = 0
        while f[i][-2] == ";"
            line = f[i].chomp.split(";;")
            p line
            item = Item.new(line[0], line[1], line[2], line[3])
            line[4] = false if line[4] == "false"
            line[5] = false if line[5] == "false"
            item.setBools(line[4], line[5])
            $items << item
            i += 1
        end
        $location = f[i].chomp
        $harBaby = f[i+1].chomp
        $kastatBaby = f[i+2].chomp
        $buyFails = f[i+3].chomp
        #debug
        itemDebug()
    else
        # $items << Item.new(name, location, usable_with, useLocation)
        $items << Item.new("nyckel", "bakom_bion", "dörr", "bakom_bion")
        $items << Item.new("boltcutters", "boltcutterStore", "grind", "framfor_bion")
        $items << Item.new("pengar", "jarntorget", "Henrik", "boltcutterStore")
    end
end

def save()
    file = File.open("savefile.txt", "w+")
    i = 0
    while i < $items.length
        file.puts $items[i].inspect
        i += 1
    end
    file.puts $location
    file.puts $harBaby
    file.puts $kastatBaby
    file.puts $buyFails
    file.close
end

def action()
    while true
        sleep TextSpeed
        puts ""
        puts "Vad vill du göra?"
        puts ""
        user_input = gets.chomp.downcase.split
        puts ""
        while user_input[0] != "avsluta"
            if user_input[0] == "hjälp"
                puts ""
                puts "Giltiga kommandon:"
                puts "  - 'kolla'"
                puts "  - 'kolla x'"
                puts "  - 'gå x'"
                puts "  - 'ta x'"
                if $location == "boltcutterStore"
                    puts "  - 'köp x'"
                end
                puts "  - 'använd x y'"
                puts "  - 'öppna x'"
                puts "  - 'kasta x'"
                puts "  - 'hjälp'"
                puts "  - 'ficka'"
                puts "  - 'avsluta'"
                
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
                if item != nil
                    item.pick_up
                else
                    puts "Det finns ingen " + user_input[1] + " här."
                end
            elsif user_input[0] == "köp"
                if $location != "boltcutterStore"
                    puts "Det finns inget att köpa här."
                else
                   return "köp " + user_input[1] 
                end
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
                    if $kastatBaby
                        puts "Du har redan kastat babyn. Det var inte en särskilt smart idé."
                    else
                        puts "Babyn faller till marken med en duns, och den börjar gråta."
                        sleep TextSpeed
                        puts "Du är i samma situation som innan, men nu med en gråtande baby. Grattis."
                        $kastatBaby = true
                    end
                elsif item != nil && !item.used?
                    puts "Det är nog inte den bästa idén att kasta bort den..."
                else
                    puts "Du har ingen " + user_input[1] + "."
                end
            elsif user_input[0] == "ficka"
                i = 0
                nope = 0
                while i < $items.length
                    if $items[i].held?
                        puts $items[i].name
                    else
                        nope += 1
                    end
                    i += 1
                end
                if nope = $items.length
                    puts "Du har inget i fickorna."
                end
            else
                puts "Ogiltig handling. Försök igen."
            end
            puts ""
            sleep TextSpeed
            puts "Vad vill du göra?"
            puts ""
            user_input = gets.chomp.split
        end
        puts ""
        puts "Vill du spara innan du avslutar?"
        puts "Y/N"
        if ["y", "ja", "yes"].include?(gets.chomp.downcase)
            save()
        end
        exit
    end
end

def intro()
    puts "Du har haft en bra natt med dina vänner på stan, men du är full som attans och i behov av grubb."
    sleep TextSpeed
    puts "Du vaggar fram i haga tills du ser en mattruck, med kebab dessutom!"
    sleep TextSpeed
    puts "Din mage leder dig fram till ståndet och fulla du langar över 70 riksdaler för en kebabrulle."
    puts ""
    sleep TextSpeed
end

def jarntorget()
    puts "Du ankommer till järntorget. Det är tyst."
    sleep TextSpeed
    puts (!getItem("pengar").held? ? "Brevid hållplatsen ser du en stor fontän i järn, med glänsande vatten." : "Brevid hållplatsen ser du en stor fontän i järn. Vattnet glänser inte längre.")
    while true
        action = action() #ex.=> "kolla dörrmatta"
        if action == "kolla fontän"
            if getItem("pengar").held? || getItem("pengar").used?
                puts "Du tittar ner i fontänen. Den är tom."
            else
                puts "Du tittar ner i fontänen, och ser en massa mynt."
                sleep TextSpeed
                puts "Det måste ju vara minst 500 kr!"
            end
        elsif action == "gå långgatan"
            puts "Du går fram till långgatan."
            $location = "langgatan"
            return nil
        elsif action == "gå spårvagn" || action == "gå stigbergstorget" || action == "gå spårvagnshållplats"
            puts "Du går till spårvagnen. Den kommer om 20min. Whelp, dags att vänta."
            sleep TextSpeed
            puts ""
            puts "[20min later]"
            sleep TextSpeed
            puts ""
            puts "Äntligen kommer spårvagnen, och du hoppar på. Vagnen är tom förutom föraren."
            sleep TextSpeed
            puts "Vid Stigbergstorget dyker en kontrollant upp. Du har ingen biljett, så du går av för att inte bli påkommen."
            $location = "stigbergstorget"
            return nil
        elsif action == "gå tillbaka"
            puts "Det finns inget 'tillbaka' att gå."
        elsif action == "kolla"
            return nil
        end
    end
end

def langgatan()
    puts "Du vandrar ner för långgatan. Till höger ser du järntorget i horisonten och till vänster en suspekt bra placerad boltcutteraffär."
    while true
        action = action() #ex.=> "kolla dörrmatta"
        if action == "gå affär" || action == "gå boltcutteraffär"
            puts "Du går in i boltcutteraffären."
            $location = "boltcutterStore"
            return nil
        elsif action == "placeholder"
            
            
        elsif action == "gå tillbaka"
            puts "Du går tillbaka till Järntorget."
            $location = "jarntorget"
            return nil
        elsif action == "kolla"
            return nil
        end
    end
end

def boltcutterStore()
    puts "du är i den suspekta boltcutteraffären. Den är fylld med boltcutter."
    while true
        action = action() #ex.=> "kolla dörrmatta"
        if action == "placeholder"

        elsif action == "köp boltcutters" # ROBIN SKRIV NÄR DU KAN PLS THANK UU <3 | OKIIII FIXAT :3
            if getItem("pengar").held?
                getItem("pengar").use("Henrik")
                puts "Du ger de våta mynten till Henrik. Hon tittar tillbaka med en trött blick."
                sleep TextSpeed
                puts "Hon mumlar 'Good enough...' och ger dig ett par boltcutters."
                getItem("boltcutters").pick_up
            elsif $buyFails == 0
                puts "Kassören Henrik tittar på dig med en halvdöd min."
                sleep TextSpeed
                puts "'Har du några pengar?'"
                sleep TextSpeed
                puts "Du rotar genom dina fickor. Du är helt pank."
                sleep TextSpeed
                puts "(-10 aura)"
                $buyFails += 1
            elsif $buyFails < 3
                puts "Kassören Henrik tittar på dig med en halvdöd min igen."
                sleep TextSpeed
                puts "'Har du några pengar?'"
                sleep TextSpeed
                puts "Du rotar genom dina fickor. Du är fortfarande helt pank."
                sleep TextSpeed
                puts "(-10 aura)"
                $buyFails += 1
            elsif $buyFails == 3
                puts "Henrik stirrar på dig."
                sleep TextSpeed
                puts "Du är fortfarande pank."
                sleep TextSpeed
                puts "(-100 aura)"
                $buyFails = 4
            else
                puts "Henrik ignorerar dig. Hon vet att dina fickor är tomma."
            end
        elsif action == "gå tillbaka" || action == "gå långgatan"
            puts "Du går tillbaka till Långgatan."
            $location = "langgatan"
            return nil
        elsif action == "kolla"
            return nil
        end
    end
end

def stigbergstorget()
    puts "Du står nu vid stigberstorget. du noterar att alla spårvagnar vänder här."
    sleep TextSpeed
    puts "Det enda intressanta som finns här är en biograf en bit bort."
    while true
        action = action() #ex.=> "kolla dörrmatta"
        if action == "placeholder"

        elsif action == "gå bio" || action == "gå biograf"
            puts "Du går fram till bion. De verkar ha stängt."
            $location = "framfor_bion"
            return nil
        elsif action == "gå tillbaka" || action == "gå järntorget"
            puts "Du väntar in nästa 3:a och åker tillbaka till Järntorget. Denna är såklart i tid."
            $location = "jarntorget"
            return nil
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
            if getItem("boltcutters").used?
                puts "Du går in bakom bion."
                $location = "bakom_bion"
                return nil
            else
                puts ($harBaby ? "Du går in i grinden. Babyn gurglar hånande" : "Du går in i grinden.")
                sleep TextSpeed
                puts "Grinden är låst med en stor kedja. Du behöver få bort den på något sätt om du ska kunna komma förbi." 
            end
        elsif action == "gå tillbaka"
            puts "Du går tillbaka till Stigbergstorget."
            $location = "stigbergstorget"
            return nil
        elsif action == "kolla"
            return nil
        end
    end
end

def bakom_bion()
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
            ending()
        elsif action == "gå tillbaka"
            puts "Du går tillbaka till bions framsida."
            $location = "framfor_bion"
            return nil
            $kastatBaby = true
        elsif action == "kolla"
            return nil
        end
    end
end

def ending()
    puts ""
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
    # puts "\e[H\e[2J"
    intro()
    while true
        puts ""
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
            puts $location
            raise "ERROR: Location Not Found"
        end
    end
end


##################TESTKOD NEDANFÖR##########################

main()
