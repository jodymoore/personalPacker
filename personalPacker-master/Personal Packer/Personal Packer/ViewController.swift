//
//  ViewController.swift
//  Personal Packer
//
//  Created by jody moore on 10/9/18.
//  Copyright © 2018 Rock Valley College. All rights reserved.
//

import UIKit

import CoreData

class ViewController: UIViewController {

    
    // outlets
    @IBOutlet weak var customername: UITextField!
    @IBOutlet weak var customeremail: UITextField!
    @IBOutlet weak var parachutetype: UITextField!
    @IBOutlet weak var packjobs: UITextField!
    
    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var btnSave: UIButton!
    
    // actions
    @IBAction func btnBack(_ sender: UIBarButtonItem) {
          self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func btnEdit(_ sender: UIButton) {
        //0a Edit contact
        customername.isEnabled = true
        customeremail.isEnabled = true
        parachutetype.isEnabled = true
        packjobs.isEnabled = true
        btnSave.isHidden = false
        btnEdit.isHidden = true
        customername.becomeFirstResponder()
        
    }
    
    //**Begin Copy**
    //3) Add ManagedObject Data Context
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    //**End Copy**
    
    
    //**Begin Copy**
    //4) Add variable contactdb (used from UITableView
    var Customerdb:NSManagedObject!
    //**End Copy**
    
    
    @IBAction func btnSave(_ sender: UIButton) {
        //1 Add Save Logic
    
        if (Customerdb != nil)
        {
            Customerdb.setValue(customername.text, forKey: "customername")
            Customerdb.setValue(customeremail.text, forKey: "customeremail")
            Customerdb.setValue(parachutetype.text, forKey: "parachutetype")
            Customerdb.setValue(Int32(packjobs.text!), forKey: "packjobs")
            
        }
        else
        {
            let entityDescription =
                NSEntityDescription.entity(forEntityName: "Customer",in: managedObjectContext)
            
            let customer = Customer(entity: entityDescription!,
                                  insertInto: managedObjectContext)
            
            customer.customername = customername.text!
            customer.customeremail = customeremail.text!
            customer.parachutetype = parachutetype.text!
            let number:Int32!  = Int32(packjobs.text!)
            customer.packjobs = number
        }
        var error: NSError?
        do {
            try managedObjectContext.save()
        } catch let error1 as NSError {
            error = error1
        }
        if let err = error {
            //if error occurs
            // status.text = err.localizedFailureReason
        } else {
            self.dismiss(animated: false, completion: nil)
            
        }
        
    }
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //**Begin Copy**
        //5 Add logic to load db. If contactdb has content that means a row was tapped on UiTableView
        
        
        if (Customerdb != nil)
        {
            customername.text = Customerdb.value(forKey: "customername") as? String
            customeremail.text = Customerdb.value(forKey: "customeremail") as? String
            parachutetype.text = Customerdb.value(forKey: "parachutetype") as? String
            packjobs.text = Customerdb.value(forKey: "packjobs") as? String
            btnSave.setTitle("Update", for: UIControlState())
            btnEdit.isHidden = false
            customername.isEnabled = false
            customeremail.isEnabled = false
            packjobs.isEnabled = false
            parachutetype.isEnabled = false
            btnSave.isHidden = true
        }else{
            btnEdit.isHidden = true
            customername.isEnabled = true
            customeremail.isEnabled = true
            parachutetype.isEnabled = true
            packjobs.isEnabled = true
        }
        customername.becomeFirstResponder()
        // Do any additional setup after loading the view.
        //Looks for single or multiple taps
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.DismissKeyboard))
        //Adds tap gesture to view
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches , with:event)
        if (touches.first as UITouch!) != nil {
            DismissKeyboard()
        }
    }
    
    @objc func DismissKeyboard(){
        //forces resign first responder and hides keyboard
        customername.endEditing(true)
        customeremail.endEditing(true)
        parachutetype.endEditing(true)
        packjobs.endEditing(true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField!) -> Bool     {
        textField.resignFirstResponder()
        return true;
    }
    
}

