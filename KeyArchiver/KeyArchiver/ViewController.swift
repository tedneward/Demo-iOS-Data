//
//  ViewController.swift
//  KeyArchiver
//
//  Created by Ted Neward on 4/28/22.
//

import UIKit

class Book: NSObject, NSCoding {
    var title: String
    var author: String
    var pageCount: Int
    var categories: [String]
    var available: Bool

    // Memberwise initializer
    init(title: String, author: String, pageCount: Int, categories: [String], available: Bool) {
        self.title = title
        self.author = author
        self.pageCount = pageCount
        self.categories = categories
        self.available = available
    }

    // MARK: NSCoding
    
    required convenience init?(coder decoder: NSCoder) {
        guard let title = decoder.decodeObject(forKey: "title") as? String,
              let author = decoder.decodeObject(forKey: "author") as? String,
              let categories = decoder.decodeObject(forKey: "categories") as? [String]
            else { return nil }
        
        self.init(
            title: title,
            author: author,
            pageCount: decoder.decodeInteger(forKey: "pageCount"),
            categories: categories,
            available: decoder.decodeBool(forKey: "available")
        )
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(self.title, forKey: "title")
        coder.encode(self.author, forKey: "author")
        coder.encodeCInt(Int32(self.pageCount), forKey: "pageCount")
        coder.encode(self.categories, forKey: "categories")
        coder.encode(self.available, forKey: "available")
    }
}

class ViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var table: UITableView!

    let file = NSHomeDirectory() + "/Documents/archive.books"
    
    var books : [Book] = [
        Book(title: "Effective Enterprise Java", author: "Ted Neward", pageCount: 450, categories: ["Java"], available: true),
        Book(title: "The Hobbit", author: "JRR Tolkien", pageCount: 400, categories: ["Fantasy"], available: true),
        Book(title: "SSCLI Essentials", author: "Ted Neward", pageCount: 350, categories: ["CLR", "C#", "C++"], available: true)
    ]

    @IBAction func loadPressed(_ sender: Any) {
        print("Load pressed")
        guard let loadedBooks =
                NSKeyedUnarchiver.unarchiveObject(withFile: file) as? [Book] else {
            let alert = UIAlertController(title: "Error", message: "Books failed to load", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        books = loadedBooks
        table.reloadData()
    }
    @IBAction func addPressed(_ sender: Any) {
        print("Add pressed!")
        books.append(Book(title: "C# In a Nutshell", author: "Ted Neward", pageCount: 650, categories: ["C#"], available: true))
        table.reloadData()
    }
    @IBAction func storePressed(_ sender: Any) {
        print("Save pressed")
        NSKeyedArchiver.archiveRootObject(books, toFile: file)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        table.dataSource = self
    }

    /* UITableDataSource */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel!.text = "\(books[indexPath.row].title) by \(books[indexPath.row].author)"
        return cell!
    }
}

