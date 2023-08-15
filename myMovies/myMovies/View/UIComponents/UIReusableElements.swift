//
//  UIReusableElements.swift
//  myMovies
//
//  Created by Alberto Kemish Flores Macias on 8/10/23.
//

import UIKit

class DismissKeyboard {
    static func dismiss() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
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
        fatalError("\(ErrorStrings.coderNotImplemented.localized)")
    }
    
    private func setupSegmentedControl(with items: [String]) {
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.removeAllSegments()
        
        for (index, item) in items.enumerated() {
            segmentedControl.insertSegment(withTitle: item, at: index, animated: false)
        }
        
        segmentedControl.selectedSegmentIndex = 0
        
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
