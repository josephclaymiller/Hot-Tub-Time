//
//  TestStripTableViewController.swift
//  Hot Tub Time
//
//  Created by Joseph Miller on 12/20/21.
//

import UIKit

class TestStripTableViewController: UITableViewController, TestStripDelegate {
    let dateFormatter = DateFormatter()
    let filename = "testStripsFile"
    var path: URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(filename)
    }
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()
    
    var testStrips: [TestStrip] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "en_US")
        
        // Load data from file if it exists
        loadData()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return testStrips.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "testStripCell", for: indexPath)

        // Configure the cell...
        let testStrip = testStrips[indexPath.row]
        cell.textLabel?.text = "\(testStrip) - \(testStrip.isGood() ? "Ok" : "Adjust Chemicals!")"
        cell.detailTextLabel?.text = "\(dateFormatter.string(from: testStrip.date))"
        
//        var cellColor: UIColor?
//        if !testStrip.isGood() {
//            cellColor = UIColor.orange
//        }
//        cell.backgroundColor = cellColor
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            testStrips.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            saveData()
        } else if editingStyle == .insert {
            // 1. Create a new instance of the appropriate class
            // 2. Insert it into the array
            // 3. Add a new row to the table view
        }
    }
    
    // MARK: - Data Persistence
    func saveData() {
        // Save test strip data to file
        if let encoded = try? encoder.encode(testStrips) {
            // save `encoded` somewhere
            if let json = String(data: encoded, encoding: .utf8) {
                print(json)
                do {
                    try json.write(to: path, atomically: true, encoding: .utf8)
                    print("Save data to file on device: \(path)")
                } catch {
                    print("Could not write json to file")
                }
            }
        }
    }
    
    func loadData() {
        print("Looking for data file to load previous data")
        let bundlePath = path.relativePath
        do {
            if let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                //print("Loaded data:")
                //print(jsonData)
                if let decoded = try? decoder.decode([TestStrip].self, from: jsonData) {
                    //print(decoded)
                    testStrips = decoded
                }
            }
        } catch {
            print(error)
        }
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "addTestStripSegue" {
            let destination = segue.destination as! AddTestStripViewController
            destination.delegate = self
        } else if segue.identifier == "showTestStripSegue" {
            let destination = segue.destination as! TestStripViewController
            // Pass the selected object to the new view controller.
            let indexPath : NSIndexPath = self.tableView.indexPathForSelectedRow! as NSIndexPath
            destination.strip = testStrips[indexPath.row]
            // pass along strip
        }
    }
    
    
    func addtestStrip(viewController: AddTestStripViewController, didTest testStrip: TestStrip?) {
        if let testStrip = testStrip {
            //testStrips.append(testStrip)
            // Add to front of array
            testStrips.insert(testStrip, at: 0)
        }
        //print(testStrips)
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
        tableView.reloadData()
        saveData()
    }
}


