//
//  ViewController.swift
//  Recipez
//
//  Created by KENNETH GRANDBERRY on 12/7/15.
//  Copyright © 2015 KENNETH GRANDBERRY. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
   
    //var recipesVC = RecipesVC()
    
    var recipes = [Recipe]()
    var mySelection = []
    
    var fetchresultsController : NSFetchedResultsController!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        tableView.delegate = self
        tableView.dataSource = self
        
       
    }
    
    override func viewDidAppear(animated: Bool) {
        fetchAndSetRequest()
        tableView.reloadData()
    }
    
    func fetchAndSetRequest() {
        let app = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = app.managedObjectContext
         let fetchRequest = NSFetchRequest(entityName: "Recipe")
            print(fetchRequest)
        
        do {
            let results = try context.executeFetchRequest(fetchRequest)
            self.recipes = results as! [Recipe]
           // print(recipes)
        }catch let err as NSError {
            print(err.debugDescription)
        }
      
    }
    
   
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "recipesVC" {
            let vc = segue.destinationViewController as! RecipesVC
            vc.selectedItem = sender as! Recipe
            
        }
   
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier("RecipeCell") as? RecipeCell {
            let recipe = recipes[indexPath.row]
            //print(recipe)
            cell.configureCell(recipe)
            return cell
            
        } else {
            return RecipeCell()
        }
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let app = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = app.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "Recipe")
        
        do {
            let results = try context.executeFetchRequest(fetchRequest)
            self.recipes = results as! [Recipe]
            let item = recipes[indexPath.row]
            performSegueWithIdentifier("recipesVC", sender: item)
        }catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    
     func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        switch editingStyle {
        case .Delete:
            // remove the deleted item from the model
            
            let app = UIApplication.sharedApplication().delegate as! AppDelegate
            let context = app.managedObjectContext
            let fetchRequest = NSFetchRequest(entityName: "Recipe")
            
            do{
                let results = try context.executeFetchRequest(fetchRequest)
                self.recipes = results as! [Recipe]
                context.deleteObject(recipes[indexPath.row] as NSManagedObject)
                recipes.removeAtIndex(indexPath.row)
                try context.save()
                
                self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
                
            } catch let err as NSError {
                print(err.debugDescription)
            }
            
        default:
            return
            
//            let appDel:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
//            let context:NSManagedObjectContext = appDel.managedObjectContext!
//            context.deleteObject(myData[indexPath.row] as NSManagedObject)
//            myData.removeAtIndex(indexPath.row)
//            context.save(nil)
//            
//            //tableView.reloadData()
//            // remove the deleted item from the `UITableView`
//            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
//        default:
//            return
            
        }
    }

}

