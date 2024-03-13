//
//  ViewController.swift
//  PrefsDemo
//
//  Created by Ted Neward on 3/13/24.
//

import UIKit

struct Person: Codable {
    var name: String
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func btnLoadPressed(_ sender: Any) { loadPrefs() }
    
    @IBAction func btnSavePressed(_ sender: Any) { savePrefs() }
    
    func savePrefs() {
        let defaults = UserDefaults.standard
        
        defaults.set(25, forKey: "Age")
        defaults.set(true, forKey: "UseTouchID")
        defaults.set(CGFloat.pi, forKey: "Pi")

        defaults.set("Paul Hudson", forKey: "Name")
        defaults.set(Date.now, forKey: "LastRun")

        let array = ["Hello", "World"]
        defaults.set(array, forKey: "SavedArray")

        let dict = ["Name": "Paul", "Country": "UK"]
        defaults.set(dict, forKey: "SavedDict")
        
        let taylor = Person(name: "Taylor Swift")
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(taylor) {
            defaults.set(encoded, forKey: "SavedPerson")
        }
    }
    
    func loadPrefs() {
        let defaults = UserDefaults.standard
        
        print(defaults.integer(forKey: "Age"))
        print(defaults.bool(forKey: "UseTouchID"))
        print(defaults.float(forKey: "Pi"))

        if let name = defaults.string(forKey: "Name") {
            print(name)
        }
        if let lastRun = defaults.object(forKey: "LastRun") {
            print(lastRun)
        }

        if let array = defaults.array(forKey: "SavedArray") {
            print(array)
        }

        if let dict = defaults.dictionary(forKey: "SavedDict") {
            print(dict)
        }

        if let savedPerson = defaults.object(forKey: "SavedPerson") as? Data {
            let decoder = JSONDecoder()
            if let loadedPerson = try? decoder.decode(Person.self, from: savedPerson) {
                print(loadedPerson.name)
            }
        }
    }

}

