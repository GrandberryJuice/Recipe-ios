//
//  CreateRecipeVC.swift
//  Recipez
//
//  Created by KENNETH GRANDBERRY on 12/7/15.
//  Copyright © 2015 KENNETH GRANDBERRY. All rights reserved.
//

import UIKit
import CoreData

class CreateRecipeVC: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var recipeTitle:UITextField!
    @IBOutlet weak var recipeIngrediates: UITextField!
    @IBOutlet weak var recipeSteps: UITextField!
    @IBOutlet weak var recipeImg: UIImageView!
    @IBOutlet weak var addRecipeBtn: UIButton!
    
    var imagePicker: UIImagePickerController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        recipeImg.layer.cornerRadius = 4.0
        recipeImg.clipsToBounds = true
   
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
        recipeImg.image = image
        
    }

    @IBAction func addImage(sender:AnyObject) {
        presentViewController(imagePicker, animated:true, completion: nil)
    }
    
    @IBAction func createRecipe(sender:AnyObject!) {
        if let title = recipeTitle.text where title != "" {
            let app = UIApplication.sharedApplication().delegate as! AppDelegate
            let context = app.managedObjectContext
            let entity = NSEntityDescription.entityForName("Recipe", inManagedObjectContext: context)!
            let recipe = Recipe(entity:entity, insertIntoManagedObjectContext:context)
            recipe.title = title
            recipe.ingredients = recipeIngrediates.text
            recipe.steps = recipeSteps.text
            recipe.setRecipeImage(recipeImg.image!)
            
            
            context.insertObject(recipe)
            
            do {
                try context.save()
            }catch {
                print("could not save recipe")
            }
            
            self.navigationController?.popViewControllerAnimated(true)
        }
    }


}
