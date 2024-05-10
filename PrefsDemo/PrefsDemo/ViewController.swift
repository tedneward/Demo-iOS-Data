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
struct Values: Codable {
    var webserviceURL:String = ""
    var itemsPerPage:Int = -1
    var backupEnabled:Bool = false
}


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Let's delete any raw plist file already present.
        let valuespath = NSHomeDirectory() + "/Documents/values.plist"
        let filemanager = FileManager.default
        if filemanager.fileExists(atPath: valuespath) {
            // If this can't delete, something is really wrong.
            // So just force the call and crash if it throws.
            try! FileManager.default.removeItem(atPath: valuespath)
        }
    }
    
    @IBAction func btnLoadPressed(_ sender: Any) { loadPrefs() }
    
    @IBAction func btnSavePressed(_ sender: Any) { savePrefs() }
    
    @IBAction func btnRawSavePressed(_ sender: Any) { saveRaw() }
    
    @IBAction func btnRawLoadPressed(_ sender: Any) { loadRaw() }
    
    // {{## BEGIN save-settings ##}}
    func savePrefs() {
        let defaults = UserDefaults.standard
        
        defaults.set("Paul Hudson", forKey: "name")
        defaults.set(25, forKey: "age")
        defaults.set(true, forKey: "useTouchID")
        defaults.set(CGFloat.pi, forKey: "pi")
        
        // These don't appear in Settings but are still stored
        defaults.set(Date.now, forKey: "LastRun")

        let array = ["Hello", "World"]
        defaults.set(array, forKey: "SavedArray")

        let dict = ["Name": "Paul", "Country": "UK"]
        defaults.set(dict, forKey: "SavedDict")
        
        let taylor = Person(name: "Taylor Swift")
        if let encoded = try? JSONEncoder().encode(taylor) {
            defaults.set(encoded, forKey: "SavedPerson")
        }
    }
    // {{## END save-settings ##}}
    // {{## BEGIN save-raw-plist ##}}
    func saveRaw() {
        // Let's try writing to a new plist file
        let values = Values(webserviceURL: "http://this.doesnt.exist.com",
                            itemsPerPage: 10,
                            backupEnabled : true)
        print("Encoding values:", values)
        
        let encoder = PropertyListEncoder()
        encoder.outputFormat = .xml

        let valuespath = URL(filePath: NSHomeDirectory() + "/Documents/values.plist")
        do {
            let data = try encoder.encode(values)
            try data.write(to: valuespath)
        } catch {
            print(error)
        }
    }
    // {{## END save-raw-plist ##}}

    // {{## BEGIN load-settings ##}}
    func loadPrefs() {
        let defaults = UserDefaults.standard
        
        // Note that only some of these will appear in the
        // Settings app; in fact, only the ones specified
        // in the "Settings.bundle/Root.plist" will show
        // up in Settings.
        if let name = defaults.string(forKey: "name") { print(name) }
        print(defaults.integer(forKey: "age"))
        print(defaults.bool(forKey: "useTouchID"))
        print(defaults.float(forKey: "pi"))

        if let lastRun = defaults.object(forKey: "LastRun") { print(lastRun) }
        if let array = defaults.array(forKey: "SavedArray") { print(array) }
        if let dict = defaults.dictionary(forKey: "SavedDict") { print(dict) }
        if let savedPerson = defaults.object(forKey: "SavedPerson") as? Data {
            let decoder = JSONDecoder()
            if let loadedPerson = try? decoder.decode(Person.self, from: savedPerson) {
                print(loadedPerson.name)
            }
        }
    }
    // {{## END load-settings ##}}
    // {{## BEGIN load-raw-plist ##}}
    func loadRaw() {
        let decoder = PropertyListDecoder()
        let valuespath = URL(filePath: NSHomeDirectory() + "/Documents/values.plist")
        do {
            let data = try Data(contentsOf: valuespath)
            let values = try decoder.decode(Values.self, from: data)
            print("Decoded values: ", values)
        } catch {
            print(error)
        }
    }
    // {{## END load-raw-plist ##}}
}

