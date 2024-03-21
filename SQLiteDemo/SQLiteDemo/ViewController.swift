//
//  ViewController.swift
//  SQLiteDemo
//
//  Created by Ted Neward on 3/20/24.
//

import UIKit

class ViewController: UIViewController {
    var db = DBManager()
    var persons = Array<Person>()

    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var edtName: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func addPerson(_ sender: Any) {
        let name = edtName.text!
        let id = db.getNewID()
        let age = Int.random(in: 18...50)
        db.insert(id: id, name: name, age: age)
        persons = db.read()
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        persons = db.read()
        if persons.isEmpty {
            db.insert(id: 1, name: "John", age: 24)
            db.insert(id: 2, name: "Mike", age: 25)
            db.insert(id: 3, name: "Harsh", age: 23)
            db.insert(id: 4, name: "Sachin", age: 44)
            db.insert(id: 5, name: "Rohit", age: 32)

            persons = db.read()
        }
    }
}
  
  
extension ViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
  
  
extension  ViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return persons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PersonCell") ?? UITableViewCell()
        cell.textLabel?.text = "Id: " + persons[indexPath.row].id.description + ", Name: " + persons[indexPath.row].name + ", age: " + persons[indexPath.row].age.description
        return cell
    }
}
