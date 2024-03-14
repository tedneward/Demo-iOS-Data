//
//  ViewController.swift
//  FileDemo
//
//  Created by Ted Neward on 3/13/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    /*
     * Returns the file: URL for the document directory on the device.
     * iOS (almost) always uses the User Domain mask, since it's not
     * a multi-user device.
     */
    func getDocumentsDirectory() -> URL {
        let path = FileManager.default.urls(
            for: .documentDirectory, in: .userDomainMask)
        return path[0]
    }
    @IBAction func btnSavePressed(_ sender: Any) { saveFile() }
    
    @IBAction func btnLoadPressed(_ sender: Any) { loadFile() }
        
    func loadFileFailable() {
        let filename = getDocumentsDirectory().appendingPathComponent("output.txt")
        
        let str = try! String(contentsOf: filename)
        let alert = UIAlertController(title: "File Contents", message: str, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            alert.dismiss(animated: true)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    func loadFile() {
        let filename = getDocumentsDirectory().appendingPathComponent("output.txt")

        do {
            let str = try String(contentsOf: filename)
            let alert = UIAlertController(title: "File Contents", message: str, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                alert.dismiss(animated: true)
            }))
            self.present(alert, animated: true, completion: nil)
        } catch {
            // failed to write file – bad permissions, bad filename, missing permissions, or more likely it can't be converted to the encoding
            NSLog("Failed to read file: \(error)")
        }
    }
    
    func saveFile() {
        let str = "Super long string here"
        let filename = getDocumentsDirectory().appendingPathComponent("output.txt")

        do {
            try str.write(to: filename, atomically: true, encoding: String.Encoding.utf8)
        } catch {
            // failed to write file – bad permissions, bad filename, missing permissions, or more likely it can't be converted to the encoding
            NSLog("Failed to write file")
        }
    }
}

