//
//  ViewController.swift
//  MyContacts
//
//  Created by Charles Konkol on 2015-10-12.
//  Copyright © 2015 Chuck Konkol. All rights reserved.
//

import UIKit
import Parse
//0) Add import for CoreData
import CoreData

class ViewController: UIViewController {
    
    //1) Add ManagedObject Data Context
    let managedObjectContext =
    (UIApplication.sharedApplication().delegate
        as! AppDelegate).managedObjectContext
    //2) Add variable contactdb (used from UITableView
    var contactdb:NSManagedObject!
    
    @IBAction func btnBack(sender: AnyObject) {
        //3) Dismiss ViewController
        self.dismissViewControllerAnimated(false, completion: nil)
    }
    
    @IBOutlet weak var latitude: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var longitude: UITextField!
    @IBOutlet weak var btnSave: UIButton!
    
    @IBOutlet weak var status: UILabel!
    @IBAction func btnSave(sender: AnyObject) {
        //4 Add Save Logic
        if (contactdb != nil)
        {
            
            contactdb.setValue(Int(latitude.text!), forKey: "latitude")
            contactdb.setValue(email.text, forKey: "email")
            contactdb.setValue(Int(longitude.text!), forKey: "longitude")
            
        }
        else
        {
            let entityDescription =
            NSEntityDescription.entityForName("Contact",inManagedObjectContext: managedObjectContext)
            
            let contact = Contact(entity: entityDescription!,
                insertIntoManagedObjectContext: managedObjectContext)
            
            // contact.latitude = latitude
            contact.email = email.text!
            // contact.longitude = longitude
        }
        var error: NSError?
        do {
            try managedObjectContext.save()
        } catch let error1 as NSError {
            error = error1
        }
        
        if let err = error {
            status.text = err.localizedFailureReason
        } else {
            self.dismissViewControllerAnimated(false, completion: nil)
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //5 Add logic to load db. If contactdb has content that means a row was tapped on UiTableView
        if (contactdb != nil)
        {
            latitude.text = contactdb.valueForKey("fullname") as? String
            email.text = contactdb.valueForKey("email") as? String
            longitude.text = contactdb.valueForKey("phone") as? String
            btnSave.setTitle("Update", forState: UIControlState.Normal)
        }
        latitude.becomeFirstResponder()
        // Do any additional setup after loading the view.
        //Looks for single or multiple taps
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        //Adds tap gesture to view
        view.addGestureRecognizer(tap)
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //6 Add to hide keyboard
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first as UITouch! {
            DismissKeyboard()
        }
        super.touchesBegan(touches , withEvent:event)
    }
    
    //7 Add to hide keyboard
    func DismissKeyboard(){
        //forces resign first responder and hides keyboard
        latitude.endEditing(true)
        email.endEditing(true)
        longitude.endEditing(true)
        
    }
    //8 Add to hide keyboard
    func textFieldShouldReturn(textField: UITextField!) -> Bool     {
        textField.resignFirstResponder()
        return true;
    }
    
    
    
    
}

