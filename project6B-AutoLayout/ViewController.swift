//
//  ViewController.swift
//  project6B-AutoLayout
//
//  Created by Ankit Shah on 1/23/21.
//

import UIKit

class ViewController: UIViewController {
    
    var mainLabel: UILabel!
    var borderLabel: UILabel!
    
    var changeAmount = 3
    var rotationAngle = 1.0
    var rotationAmount = 1.0

    @IBOutlet var frameLabel: UILabel!
    @IBOutlet var boundsLabel: UILabel!
    @IBOutlet var originLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        originLabel.text = ""
        frameLabel.text = ""
        boundsLabel.text = ""
        
        mainLabel = UILabel()
        mainLabel.frame = CGRect(x: 100, y: 100, width: 200, height: 200)
        mainLabel.backgroundColor = .gray
        //mainLabel.sizeToFit()
        
        mainLabel.layer.borderWidth = 1
        mainLabel.layer.borderColor = UIColor.red.cgColor
        
        borderLabel = UILabel()
        borderLabel.layer.borderColor = UIColor.green.cgColor
        borderLabel.layer.borderWidth = 1
        borderLabel.frame = mainLabel.frame
        //mainLabel.layer.opacity = 0.4
        
        
        
        view.addSubview(mainLabel)
        view.addSubview(borderLabel)
    }

    @IBAction func buttonPressed(_ sender: UIButton) {
        
        switch sender.tag {
        case 0: // up
            mainLabel.center.changeY(by: -changeAmount)
        case 1: // left
            mainLabel.center.changeX(by: -changeAmount)
        case 2: // right
            mainLabel.center.changeX(by: changeAmount)
        case 3:
            mainLabel.center.changeY(by: changeAmount)
        case 4:
            rotationAngle -= rotationAmount
            mainLabel.transform = CGAffineTransform(rotationAngle: CGFloat(Double(rotationAngle) * Double.pi / 180))
        case 5:
            rotationAngle += rotationAmount
            mainLabel.transform = CGAffineTransform(rotationAngle: CGFloat(Double(rotationAngle) * Double.pi / 180))
        default:
            print("default. ERROR")
        }
        borderLabel.bounds = mainLabel.frame
        borderLabel.center = mainLabel.center
        
        updateLabels()
        
    }
    
    
    func updateLabels() {
        let fOriginX = String(format: "%.2f", mainLabel.frame.origin.x)
        let fOriginY = String(format: "%.2f", mainLabel.frame.origin.y)
        let fSizeH = String(format: "%.2f", mainLabel.frame.size.height)
        let fSizeW = String(format: "%.2f", mainLabel.frame.size.width)
        
        frameLabel.text = "F X:\(fOriginX) Y:\(fOriginY) H:\(fSizeH) W:\(fSizeW)"
        frameLabel.sizeToFit()
        boundsLabel.text = "B X:\(mainLabel.bounds.origin.x) Y:\(mainLabel.bounds.origin.y) H:\(mainLabel.bounds.size.height) W:\(mainLabel.bounds.size.width)"
        boundsLabel.sizeToFit()
        
        
    }
    
}



extension CGPoint {
    
    mutating func changeX(by: Int = 1) {
        self.x += CGFloat(by)
    }
    mutating func changeY(by: Int = 1) {
        self.y += CGFloat(by)
    }
}
