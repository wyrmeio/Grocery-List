//
//  GroceryListViewController.swift
//  Grocery List
//
//  Created by Idris Jafer on 6/9/15.
//  Copyright (c) 2015 Idris Jafer. All rights reserved.
//

import UIKit
import CoreData

class GroceryListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    @IBOutlet var groceryList: UITableView!
    
    var groceryItems:[Grocery] = []
    var postion:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.groceryList.delegate = self
        self.groceryList.dataSource = self
        var context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        var request = NSFetchRequest(entityName: "Grocery")
        self.groceryItems = context?.executeFetchRequest(request, error: nil) as! [Grocery]
        //self.groceryList.reloadData()
    }
    
    override func viewDidAppear(animated: Bool) {
        var context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        var request = NSFetchRequest(entityName: "Grocery")
        self.groceryItems = context?.executeFetchRequest(request, error: nil) as! [Grocery]
        self.groceryList.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.groceryItems.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.groceryList.dequeueReusableCellWithIdentifier("Cell") as! UITableViewCell
        cell.textLabel?.text = "\(self.groceryItems[indexPath.row].item)"
        cell.detailTextLabel?.text = "Qty: " + "\(self.groceryItems[indexPath.row].qty)" + " - " + "\(self.groceryItems[indexPath.row].note)"
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("editItem", sender: self)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            var context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
            var request = NSFetchRequest(entityName: "Grocery")
            context?.deleteObject(self.groceryItems[indexPath.row])
            self.groceryItems.removeAtIndex(indexPath.row)
            context?.save(nil)
            self.groceryList.reloadData()
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "editItem" {
            let nextViewController = segue.destinationViewController as! GroceryItemViewController
            let indexPath = self.groceryList.indexPathForSelectedRow()?.row
            nextViewController.position = indexPath!
        }
    }


}

