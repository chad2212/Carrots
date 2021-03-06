    //
    //  newGroceryItem.swift
    //  Carrot
    //
    //  Created by Shungheon Chai on 4/11/17.
    //  Copyright © 2017 Chad Chai. All rights reserved.
    //
    
    import UIKit
    import SQLite
    
    //CONTROLLER FOR ADDING GROCERY ITEMS 
    class newGroceryItemController: UIViewController {
        
        
        var db:Connection? = nil
        
        @IBOutlet var foodNameField: UITextField!
        @IBOutlet var countNumber: UILabel!
        @IBOutlet var measurementTextField: UITextField!
        @IBOutlet var foodLocationChooser: UISegmentedControl!
        @IBOutlet var foodTypeChooser: UISegmentedControl!
        
        @IBOutlet var purchasedDateField: UITextField!
        @IBOutlet var expirationDateField: UITextField!
        

        

        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view, typically from a nib.
            let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            db = try? Connection("\(path)/db.sqlite3")
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
   
        @IBAction func countStepper(_ sender: UIStepper) {
            countNumber.text = Int(sender.value).description
        }
        
        //these are teh segmented controls  (location and food type fields)
        
        @IBAction func createFoodItem(_ sender: UIButton) {
            let measurementTextField = self.measurementTextField.text!
            let foodName = foodNameField.text!
            let count = Double(countNumber.text!)
            
            var foodType = "";
            if(foodTypeChooser.selectedSegmentIndex == 0)
            {
                foodType = "Meat";
            }
            else if(foodTypeChooser.selectedSegmentIndex == 1)
            {
                foodType = "Produce";
            }
            else if(foodTypeChooser.selectedSegmentIndex == 2)
            {
                foodType = "Dairy";
            }
            else
            {
                foodType = "Others";
            }
            
            var location = "";
            if(foodLocationChooser.selectedSegmentIndex == 0)
            {
                location = "Refrigerator";
            }
            else if(foodLocationChooser.selectedSegmentIndex == 1)
            {
                location = "Pantry";
            }
            else
            {
                location = "Freezer";
            }
            
            //let purchasedDate = stringToDate(dateInString: purchasedDateField.text!)
            //let expirationDate = stringToDate(dateInString: expirationDateField.text!)
            
            let purchasedDate = purchasedDateField.text!
            let expirationDate = expirationDateField.text!
            
            print("Attempting to add food item with \(foodName), \(count), \(location), \(foodType), \(purchasedDate), \(expirationDate)")
            
            SQLiteDB.instance.addGroceryItem(addName: foodName, addCount: count!, addStoredLocation: location, addPurchasedDate: purchasedDate, addExpiringDate: expirationDate, addFoodType: foodType, addMeasurementType: measurementTextField)
            
        }
        
        @IBAction func purchaseDateTapped(_ sender: Any) {
            let datePickerView  : UIDatePicker = UIDatePicker()
            datePickerView.datePickerMode = UIDatePickerMode.date
            
            
            let toolBar = UIToolbar()
            toolBar.barStyle = UIBarStyle.default
            toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
            toolBar.sizeToFit()
            let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(newGroceryItemController.purchasedDateDonePicker))
            toolBar.setItems([doneButton], animated: false)
            toolBar.isUserInteractionEnabled = true
            purchasedDateField.inputView = datePickerView;
            purchasedDateField.inputAccessoryView = toolBar;
            
            
            datePickerView.addTarget(self ,action: #selector(handlePurchaseDatePicker), for: UIControlEvents.valueChanged)
        }
        
        func handlePurchaseDatePicker(sender: UIDatePicker) {
            let timeFormatter = DateFormatter()
            timeFormatter.dateFormat = "yyyy/MM/dd";
            purchasedDateField.text = timeFormatter.string(from: sender.date)
        }
        
        func purchasedDateDonePicker() {
            
            purchasedDateField.resignFirstResponder()
            
        }
        
        
        

        @IBAction func expirationDateTapped(_ sender: Any) {
            let datePickerView  : UIDatePicker = UIDatePicker()
            datePickerView.datePickerMode = UIDatePickerMode.date
            expirationDateField.inputView = datePickerView;
            
            let toolBar = UIToolbar()
            toolBar.barStyle = UIBarStyle.default
            toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
            toolBar.sizeToFit()
            let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(newGroceryItemController.expirationDateDonePicker))
            toolBar.setItems([doneButton], animated: false)
            toolBar.isUserInteractionEnabled = true
            expirationDateField.inputView = datePickerView;
            expirationDateField.inputAccessoryView = toolBar;
            
            
            datePickerView.addTarget(self,action: #selector(handleExpirationDatePicker), for: UIControlEvents.valueChanged)

        }
        
        
        func handleExpirationDatePicker(sender: UIDatePicker) {
            let timeFormatter = DateFormatter()
            timeFormatter.dateFormat = "yyyy/MM/dd";
            expirationDateField.text = timeFormatter.string(from: sender.date)
        }
        
        func expirationDateDonePicker() {
            
            expirationDateField.resignFirstResponder()
            
        }
        
        
        
        
        
        
        
        
        func checkIfExist(name:String) -> Bool
        {
            for item in localGroceryList
            {
                if (item.name == name)
                {
                    return true
                }
            }
            return false
        }
        func addItem(name:String, count:Int)
        {
            var counter : Int = 0
            for item in localGroceryList
            {
                if (item.name == name)
                {
                    localGroceryList[counter].count+=1
                }
                counter+=1
            }
        }
    }
