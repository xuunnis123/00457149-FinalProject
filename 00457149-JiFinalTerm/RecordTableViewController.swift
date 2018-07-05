//
//  RecordTableViewController.swift
//  00457149
//
//  Created by User16 on 2018/6/26.
//  Copyright © 2018年 User21. All rights reserved.
//

import UIKit

class RecordTableViewController: UITableViewController {
    
    var records = [Record]()
    
    @IBAction func goBackToRecordTable(segue:UIStoryboardSegue){
        let controller = segue.source as? EditRecordTableViewController
        
        if let record = controller?.record{
            if let row = tableView.indexPathForSelectedRow?.row{
                records[row] = record
            }else{
                records.insert(record,at:0)
            }
            
            Record.saveToFile(records: records)
            
            tableView.reloadData()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let records = Record.readRecordsFromFile(){
            self.records = records
        }
        tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
  
        if let records = Record.readRecordsFromFile(){
            self.records = records
        }
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return records.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recordCell", for: indexPath)as! RecordTableViewCell
        
        let record = records[indexPath.row]
        cell.amountLabel.text = String(record.amount)
        cell.dateLabel.text = "\(record.year)\\\(record.month)\\\(record.day)"
        cell.classificationLabel.text = record.classification
        if(indexPath.row % 2 == 1){
            cell.backgroundColor = UIColor(red: 1.00, green: 0.93, blue: 0.86, alpha: 1.0)
        }

        // Configure the cell...

        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        records.remove(at: indexPath.row)
        Record.saveToFile(records: records)
        tableView.reloadData()
    }
    

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
