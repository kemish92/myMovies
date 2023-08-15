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
    
    func navigationButton(viewController: UIViewController, title: String, titleFontSize: CGFloat) {
        viewController.navigationItem.setHidesBackButton(true, animated: true)
        let toggleMenuButton = UIBarButtonItem(
            image: UIImage(systemName: "list.dash"),
            style: .done,
            target: self,
            action: #selector(toggleMenu)
        )
        self.viewController = viewController
        viewController.navigationItem.rightBarButtonItems = [toggleMenuButton]
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: titleFontSize, weight: .bold)
        
        viewController.navigationItem.titleView = titleLabel
        viewController.navigationController?.navigationBar.tintColor = .white
        viewController.navigationController?.navigationBar.backgroundColor = UIColor(red: 46/255, green: 55/255, blue: 58/255, alpha: 1.0)
    }
    
    @objc func toggleMenu(_ sender: UIBarButtonItem) {
        if let viewController = viewController {
            let actionSheet = UIAlertController(title: nil, message: AlertStrings.profileActionTitle.localized, preferredStyle: .actionSheet)
            let reportAction = UIAlertAction(title: AlertStrings.profile.localized, style: .default) { (action) in
                self.showProfile(action: "profile")
            }

            let blockAction = UIAlertAction(title: AlertStrings.logOut.localized, style: .destructive) { (action) in
                self.showProfile(action: "logout")
            }

            let cancelAction = UIAlertAction(title: AlertStrings.cancel.localized, style: .cancel) { (action) in
                
            }

            actionSheet.addAction(reportAction)
            actionSheet.addAction(blockAction)
            actionSheet.addAction(cancelAction)
            viewController.present(actionSheet, animated: true, completion: nil)
        }
    }
    
    func showProfile(action: String){
        if let viewController = viewController {
            switch action {
            case "profile":
                viewController.present(ProfileViewController(), animated: true, completion: nil)
            case "logout":
                if let sessionId = SessionManager.shared.readSessionId() {
                    deleteSeason(sessionId: sessionId)
                }
                let vc = LoginViewController()
                viewController.navigationController?.show(vc, sender: nil)
            default:
                print("cancel")
            }
        }

    }
    
    func deleteSeason(sessionId: String) {
        let headers = [
            "accept": "application/json",
            "content-type": "application/json",
            "Authorization": "Bearer \(DefaultValuesString.mainToken.localized)"
        ]
        
        let parameters = ["session_id": "\(sessionId)"]
        
        do {
            let postData = try JSONSerialization.data(withJSONObject: parameters)
            
            let request = NSMutableURLRequest(url: NSURL(string: "\(DefaultValuesString.mainUrl.localized)\(DefaultValuesString.authenticationSession.localized)")! as URL,
                                              cachePolicy: .useProtocolCachePolicy,
                                              timeoutInterval: 10.0)
            request.httpMethod = "DELETE"
            request.allHTTPHeaderFields = headers
            request.httpBody = postData
            
            let session = URLSession.shared
            let dataTask = session.dataTask(with: request as URLRequest) { (data, response, error) in
                if let error = error {
                    print(error)
                } else {
                    if let httpResponse = response as? HTTPURLResponse {
                        print(httpResponse)
                    }
                }
            }
            
            dataTask.resume()
        } catch {
            print(error)
        }
    }
}

protocol CustomSegmentedControlDelegate: AnyObject {
    func segmentedControlDidChange(to index: Int)
}

class CustomSegmentedControlView: UIView {
    weak var delegate: CustomSegmentedControlDelegate?
    let segmentedControl = UISegmentedControl()
    init(items: [String]) {
        super.init(frame: .zero)
        setupSegmentedControl(with: items)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSegmentedControl(with items: [String]) {
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.removeAllSegments()
        
        for (index, item) in items.enumerated() {
            segmentedControl.insertSegment(withTitle: item, at: index, animated: false)
        }
        
        addSubview(segmentedControl)
        
        NSLayoutConstraint.activate([
            segmentedControl.leadingAnchor.constraint(equalTo: leadingAnchor),
            segmentedControl.trailingAnchor.constraint(equalTo: trailingAnchor),
            segmentedControl.topAnchor.constraint(equalTo: topAnchor),
            segmentedControl.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func getSelectedIndex() -> Int {
        return segmentedControl.selectedSegmentIndex
    }
    
    func setTextColor(_ color: UIColor, backgroundColor: UIColor, selectedSegmentColor: UIColor) {
        let attributes = [NSAttributedString.Key.foregroundColor: color]
        segmentedControl.setTitleTextAttributes(attributes, for: .normal)
        segmentedControl.backgroundColor = backgroundColor
        segmentedControl.selectedSegmentTintColor = selectedSegmentColor
    }
    
    @objc func changeSelector(_ segmentedControl: UISegmentedControl) {
        delegate?.segmentedControlDidChange(to: segmentedControl.selectedSegmentIndex)
    }
}

class DateFormatterHelper {
    static func convertDate(_ dateString: String) -> String? {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "MMM dd, yyyy"
        
        if let date = inputFormatter.date(from: dateString) {
            return outputFormatter.string(from: date)
        }
        
        return nil
    }
}

class DateFormatterHelperYear {
    static func formatYearFromDate(dateString: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if let date = dateFormatter.date(from: dateString) {
            let yearFormatter = DateFormatter()
            yearFormatter.dateFormat = "yyyy"
            return yearFormatter.string(from: date)
        }
        
        return nil
    }
}

class TimeFormatterHelper {
    static func formatTimeFromMinutes(minutes: Int) -> String {
        let hours = minutes / 60
        let remainingMinutes = minutes % 60
        
        let formattedTime = "\(hours):\(String(format: "%02d", remainingMinutes))"
        return formattedTime
    }
}

class ImageLoader {
    static func loadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("\(ErrorStrings.loadingImageError.localized): \(error)")
                completion(nil)
                return
            }
            
            if let data = data, let image = UIImage(data: data) {
                completion(image)
            } else {
                completion(nil)
            }
        }.resume()
    }
}
