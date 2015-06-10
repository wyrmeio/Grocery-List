//
//  GroceryItemViewController.swift
//  Grocery List
//
//  Created by Idris Jafer on 6/9/15.
//  Copyright (c) 2015 Idris Jafer. All rights reserved.
//

import UIKit
import CoreData

class GroceryItemViewController: UIViewController {
    
    @IBOutlet var itemName: UITextField!
    @IBOutlet var itemQuantity: UITextField!
    @IBOutlet var itemNote: UITextField!
  
    var items:[Grocery] = []
      var position:Int = -1
    
    @IBAction func cancelButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func saveButtonPressed(sender: AnyObject) {
        var context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        if self.position == -1 {
            var newItem = NSEntityDescription.insertNewObjectForEntityForName("Grocery", inManagedObjectContext: context!) as! Grocery
            newItem.item = self.itemName.text
            newItem.qty = self.itemQuantity.text
            newItem.note = self.itemNote.text
        } else {
            var request = NSFetchRequest(entityName: "Grocery")
            self.items = context?.executeFetchRequest(request, error: nil) as! [Grocery]
            self.items[self.position].item = self.itemName.text
            self.items[self.position].qty = self.itemQuantity.text
            self.items[self.position].note = self.itemNote.text
            self.position = -1
        }
        context!.save(nil)
        self.dismissViewControllerAnimated(true, completion: nil)
        self.itemName.text = ""
        self.itemQuantity.text = ""
        self.itemNote.text = ""
    }
    
    override func viewDidLoad() {
        var context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        var request = NSFetchRequest(entityName: "Grocery")
        self.items = context?.executeFetchRequest(request, error: nil) as! [Grocery]
        
        if self.position != -1 {
            self.itemName.text = self.items[self.position].item
            self.itemQuantity.text = self.items[self.position].qty
            self.itemNote.text = self.items[self.position].note
        }
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    
}
