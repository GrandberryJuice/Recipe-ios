//
//  CreateRecipeVC.swift
//  Recipez
//
//  Created by KENNETH GRANDBERRY on 12/7/15.
//  Copyright © 2015 KENNETH GRANDBERRY. All rights reserved.
//

import UIKit
import CoreData

class CreateRecipeVC: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    
    @IBOutlet weak var recipeTitle:UITextField!
    @IBOutlet weak var recipeIngrediates: UITextField!
    @IBOutlet weak var recipeSteps: UITextField!
    @IBOutlet weak var recipeImg: UIImageView!
    @IBOutlet weak var scrollview:UIScrollView!
    @IBOutlet weak var addRecipeBtn: UIButton!
    
    var imagePicker: UIImagePickerController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        recipeImg.layer.cornerRadius = 4.0
        recipeImg.clipsToBounds = true
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
//        self.scrollview.contentSize.height = 600

            scrollview.contentInset = UIEdgeInsetsMake(0, 0, 600, 0)
    }
    
    override func viewWillLayoutSubviews() {
        self.scrollview.frame = self.view.bounds
        self.scrollview.contentSize.height = 600
        self.scrollview.contentSize.width = 0
        
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        scrollview.setContentOffset(CGPointMake(0, 250), animated: true)
    }
//
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
        recipeImg.image = image
        
    }

    @IBAction func addImage(sender:AnyObject) {
        presentViewController(imagePicker, animated:true, completion: nil)
    }
    
    @IBAction func createRecipe(sender:AnyObject!) {
        
        if let title = recipeTitle.text where title != "", let ingredients = recipeIngrediates.text where ingredients != "", let steps = recipeSteps.text where steps != ""  {
            let app = UIApplication.sharedApplication().delegate as! AppDelegate
            let context = app.managedObjectContext
            let entity = NSEntityDescription.entityForName("Recipe", inManagedObjectContext: context)!
            let recipe = Recipe(entity:entity, insertIntoManagedObjectContext:context)
            recipe.title = title
            recipe.ingredients = ingredients
            recipe.steps = steps
            recipe.setRecipeImage(recipeImg.image!)
            context.insertObject(recipe)
            
            do {
                try context.save()
            }catch {
                print("could not save recipe")
            }
                self.navigationController?.popViewControllerAnimated(true)
            
        } else {
            let alertController = UIAlertController(title: "Missing Data", message:
                "Please enter data into each of the fields and upload an image", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        
    }

    func dismissKeyboard() {
        view.endEditing(true)
    }

}
