import Challenge1 "./custom";
import Challenge2 "./animal";
import list "./list";
import List "mo:base/List";

actor {
    /*
        Challenge 1 : Create two files called custom.mo and main.mo, create your own type inside custon.mo and import it in your main.mo file. In main, create a public function fun that takes no argument but return a value of your custom type.
    */
    public func fun() : async Challenge1.MyProfile {
        return {
            name = "Linh Nguyen";
            age = 30;
        };
    };

    /*
        Challenge 2 : Create a new file called animal.mo with at least 2 property (specie of type Text, energy of type Nat), import this type in your main.mo and create a variable that will store an animal.
    */
    var lion : Challenge2.Animal = {
        specie  = "Lion";
        energy  = 10;
    };

    /*
        Challenge 4 : In main.mo create a public function called create_animal_then_takes_a_break that takes two parameter : a specie of type Text, an number of energy point of type Nat and returns an animal. This function will create a new animal based on the parameters passed and then put this animal to sleep before returning it ! zzz
    */
    public func create_animal_then_takes_a_break(specie : Text, energy : Nat) : async Challenge2.Animal {
        let newAnimal : Challenge2.Animal = {
            specie = specie;
            energy = energy;
        };
        return Challenge2.animal_sleep(newAnimal);
    };

    /*
        Challenge 5 : In main.mo, import the type List from the base Library and create a list that stores animal.
    */
    var animals = List.nil<Challenge2.Animal>();

    /*
        Challenge 6 : In main.mo : create a function called push_animal that takes an animal as parameter and returns nothing this function should add this animal to your list created in challenge 5. Then create a second functionc called get_animals that takes no parameter but returns an Array that contains all animals stored in the list.
    */

    public func push_animal(a: Challenge2.Animal) : async () {
        animals := List.push<Challenge2.Animal>(a, animals);
    };

    public func get_animals() : async [Challenge2.Animal] {
        return List.toArray(animals);
    };

    /*
        Testing list.mo - Challenge 7 - 11 
    */
    public func checknull() : async Bool {
        list.is_null<Challenge2.Animal>(animals);
    };

    public func takelast() : async ?Challenge2.Animal {
        list.last<Challenge2.Animal>(animals);
    };

    public func getSize() : async Nat {
        list.size<Challenge2.Animal>(animals);
    };

    public func getIndex(n : Nat) : async ?Challenge2.Animal {
        list.get<Challenge2.Animal>(animals, n);
    };

    public func getReverse() : async [Challenge2.Animal] {
        let result = list.reverse<Challenge2.Animal>(animals);
        return List.toArray(result);
    };
};