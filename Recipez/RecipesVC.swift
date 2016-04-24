//
//  Recipes.swift
//  Recipez
//
//  Created by KENNETH GRANDBERRY on 4/17/16.
//  Copyright © 2016 KENNETH GRANDBERRY. All rights reserved.
//


import UIKit
import Foundation
import CoreData

class RecipesVC: UIViewController {
    
    @IBOutlet weak var currentTitle:UILabel!
    @IBOutlet weak var currentRecipe:UITextView!
    @IBOutlet weak var currentSteps:UITextView!
    
    var createRecipeVC = CreateRecipeVC()
    var recipeCell = RecipeCell()
    
    var selectedItem: Recipe!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.currentTitle = CreateRecipeVC.recipeTitle
        setup()
    }
    
    @IBAction func CloseVC (sender:AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func setup() {
        currentTitle.text = selectedItem.title
        currentRecipe.text = selectedItem.ingredients
        currentSteps.text =  selectedItem.steps
        
    }
    
}
