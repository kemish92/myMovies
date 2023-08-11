//
//  MoviesMainViewController.swift
//  myMovies
//
//  Created by Alberto Kemish Flores Macias on 8/11/23.
//

import UIKit

class MoviesMainViewController: UIViewController {
    var customNavBarCreator: CustomNavBarCreator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.customGrayForNavBar
        customNavBarCreator = CustomNavBarCreator()
        customNavBarCreator.navigationButton(viewController: self, title: "Custom Title")
    }

}
