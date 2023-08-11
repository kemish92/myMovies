//
//  UIReusableElements.swift
//  myMovies
//
//  Created by Alberto Kemish Flores Macias on 8/10/23.
//

import UIKit

class LeftSpacingInputs {
    func setLeftViews(textField: UITextField){
        let leftview = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 10, height: textField.frame.size.height))
        textField.leftView = leftview
        textField.leftViewMode = .always
    }
}

class DismissKeyboard {
    static func dismiss() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

class CustomAlerts {
    func alertMessage(title: String, message: String, viewController: UIViewController){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(action)
        viewController.present(alert, animated: true)
    }
}

class CustomNavBarCreator {
    weak var viewController: UIViewController?
    func navigationButton(viewController: UIViewController, title: String) {
        viewController.navigationItem.setHidesBackButton(true, animated: true)
        let toggleMenuButton = UIBarButtonItem(
            image: UIImage(systemName: "line.3.horizontal"),
            style: .done,
            target: self,
            action: #selector(toggleMenu)
        )
        viewController.navigationItem.rightBarButtonItems = [toggleMenuButton]
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.textColor = .white
        viewController.navigationItem.titleView = titleLabel
        viewController.navigationController?.navigationBar.backgroundColor = UIColor(red: 26/255, green: 26/255, blue: 26/255, alpha: 1)
        viewController.navigationController?.navigationBar.tintColor = .white
        viewController.navigationController?.navigationBar.backgroundColor = UIColor(red: 46/255, green: 55/255, blue: 58/255, alpha: 1.0)
    }
    
    @objc func toggleMenu(_ sender: UIBarButtonItem) {
        print("clicked")
    }
}

