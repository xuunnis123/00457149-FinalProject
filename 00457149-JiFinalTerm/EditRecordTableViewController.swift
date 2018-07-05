//
//  EditRecordTableViewController.swift
//  00457149
//
//  Created by User16 on 2018/6/26.
//  Copyright © 2018年 User21. All rights reserved.
//

import UIKit

class EditRecordTableViewController: UITableViewController , UIPickerViewDelegate ,  UIPickerViewDataSource{
    // UIPickerViewDataSource 必須實作的方法：UIPickerView 有幾列可以選擇
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 2
        
    }
    // UIPickerViewDataSource 必須實作的方法：UIPickerView 各列有多少行資料
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        // 返回陣列 meals 的成員數量
        if component == 0{
        return amount.count
        }
        return classification.count
        
    }
    // UIPickerView 每個選項顯示的資料
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        // 設置為陣列 meals 的第 row 項資料
        if component == 0
        {return amount[row]}
       return classification[row]
        
    }
    // UIPickerView 改變選擇後執行的動作
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // 將 UITextField 的值更新為陣列 meals 的第 row 項資料
        if component == 0
        {amountTextField.text = amount[row]}
        classificationTextField.text = classification[row]
       // amountTextField.text = amount[row]
    }
    
    ///////
    
    
    /////
    
    // 金額, 日期, 分類, 備註
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var classificationTextField: UITextField!
    @IBOutlet weak var noteTextView: UITextView!
    
    // 分類
    let classification = ["酷","開心","爽", "戀愛","良好", "輕鬆","普通","幸福","沒特別","差勁", "７pupu","生病","厭煩","疲倦", "沮喪","難過","糟透","痛苦","大哭","沒耐心"]
    let amount = ["工作","放鬆","朋友","約會","做運動","派對","看電影","閱讀","玩遊戲","購物","旅行","美食","清潔","唸書","專題","球賽","作業","上課","考試","睡覺"]
    // 日期
    var Yformatter: DateFormatter! = nil
    var Mformatter: DateFormatter! = nil
    var Dformatter: DateFormatter! = nil
    var Wformatter: DateFormatter! = nil
    var myDatePicker : UIDatePicker!
    var y: String!
    var m: String!
    var d: String!
    var w: String!

    var record: Record?
    var add = false
    
    // Done
    @IBAction func doneButtonPressed(_ sender: Any) {
       
        if amountTextField.text?.count == 0
        {
            let alertController = UIAlertController(title: "您沒有輸入活動哦", message: nil, preferredStyle: .alert)
            let action = UIAlertAction(title: "知道了", style: .default, handler: nil)
            alertController.addAction(action)
            present(alertController, animated: true, completion: nil)
            return
        }
   
        performSegue(withIdentifier: "goBackToRecordTableWithSegue", sender: nil)
        
    }
    
    // MARK: - Navigation
    
    // In    reparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if record == nil {
            record = Record(year: y!, month: m!, day: d!, week: w!, amount: amountTextField.text!, classification: classificationTextField.text!, note: noteTextView.text!)
        } else {
            record?.year = y!
            record?.month = m!
            record?.day = d!
            record?.week = w!
            record?.amount = amountTextField.text!
            record?.classification = classificationTextField.text!
            record?.note = noteTextView.text!
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        /***** classification *****/
        // 建立 UIPickerView
        let myPickerView = UIPickerView()
        let myPickerView2 = UIPickerView()
        
        // 設定 UIPickerView 的 delegate & dataSource
        myPickerView.delegate = self
        myPickerView.dataSource = self
        myPickerView2.delegate = self
        myPickerView2.dataSource = self
        // 將 UITextField 原先鍵盤的視圖更換成 UIPickerView
        classificationTextField.inputView = myPickerView
        amountTextField.inputView = myPickerView2
        // 設置 UITextField 預設的內容
        classificationTextField.text = classification[0]
        amountTextField.text = amount[0]
        /***** data *****/
        // 初始化 formatter 並設置日期顯示的格式
        Yformatter = DateFormatter()
        Yformatter.dateFormat = "yyyy"
        Mformatter = DateFormatter()
        Mformatter.dateFormat = "MM"
        Dformatter = DateFormatter()
        Dformatter.dateFormat = "dd"
        Wformatter = DateFormatter()
        Wformatter.dateFormat = "EEE"
        
        // 建立一個 UIDatePicker
        myDatePicker = UIDatePicker()
        
        // 設置 UIDatePicker 格式
        myDatePicker.datePickerMode = .date
        
        // 設置 UIDatePicker 預設日期為現在日期
        myDatePicker.date = Date()
        
        // 將 UITextField 原先鍵盤的視圖更換成 UIDatePicker
        dateTextField.inputView = myDatePicker
        
        // 設置 UITextField 預設的內容
        y = Yformatter.string(from: myDatePicker.date)
        m = Mformatter.string(from: myDatePicker.date)
        d = Dformatter.string(from: myDatePicker.date)
        w = Wformatter.string(from: myDatePicker.date)
        dateTextField.text = y + "\\" + m + "\\" + d
        
        // ToolBar
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.sizeToFit()
        
        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.doneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.cancelClick))
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        dateTextField.inputAccessoryView = toolBar
        
        // 增加一個觸控事件
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboard(tapG:)))
        
        tap.cancelsTouchesInView = false
        
        // 加在最基底的 self.view 上
        self.view.addGestureRecognizer(tap)
        
        if let record = record {
            dateTextField.text = "\(record.year)\\\(record.month)\\\(record.day)"
            //amountTextField.text = String(record.amount)
            //
            amountTextField.text = record.amount
            classificationTextField.text = record.classification
            noteTextView.text = record.note
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // 按空白處會隱藏編輯狀態
    @objc func hideKeyboard(tapG:UITapGestureRecognizer){
        self.view.endEditing(true)
    }

    @objc func doneClick() {
        y = Yformatter.string(from: myDatePicker.date)
        m = Mformatter.string(from: myDatePicker.date)
        d = Dformatter.string(from: myDatePicker.date)
        w = Wformatter.string(from: myDatePicker.date)
        dateTextField.text = y + "\\" + m + "\\" + d
        dateTextField.resignFirstResponder()
    }
    
    @objc func cancelClick() {
        dateTextField.resignFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
/* 這段要刪除, 不然會顯示不出畫面, 因為 return 0, 所以 section 顯示數量為０
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
*/
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
