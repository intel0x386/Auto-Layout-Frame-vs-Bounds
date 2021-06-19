//
//  ViewController.swift
//  project6B-AutoLayout
//
//  Created by Ankit Shah on 1/23/21.
//

import UIKit

class ViewController: UIViewController {
	
	var redBox: UILabel!
	var borderLabel: UILabel!
	@IBOutlet var slider: UISlider!
	
	var changeAmount = 1
	var rotationAngle = 1.0
	var rotationAmount = 1.0
	let frameColor = UIColor.systemPurple
	let boxColor = UIColor.red
	
	@IBOutlet var labelOne: UILabel!
	@IBOutlet var labelTwo: UILabel!
	@IBOutlet var labelThree: UILabel!
	var animator: UIViewPropertyAnimator! = nil
	
	@IBAction func sliderChanged(_ sender: UISlider) {
		animator.fractionComplete = CGFloat(sender.value)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		labelOne.text = ""
		labelTwo.text = ""
		labelThree.text = ""
		
		redBox = UILabel()
		redBox.frame = CGRect(x: 100, y: 100, width: 200, height: 200)
		redBox.backgroundColor = boxColor
		
		
		borderLabel = UILabel()
		borderLabel.layer.borderColor = frameColor.cgColor
		borderLabel.layer.borderWidth = 1
		borderLabel.frame = redBox.frame
		
		
		view.addSubview(redBox)
		view.addSubview(borderLabel)
		
		animator = UIViewPropertyAnimator(duration: 5, curve: .linear) {
			self.redBox.center.changeX(by: self.changeAmount)
		}
		
		updateLabels()
		
	}
	
	@IBAction func buttonPressed(_ sender: UIButton) {
		
		switch sender.tag {
		case 0: // up
			redBox.center.changeY(by: -changeAmount)
		case 1: // left
			redBox.center.changeX(by: -changeAmount)
		case 2: // right
			redBox.center.changeX(by: changeAmount)
		case 3:
			redBox.center.changeY(by: changeAmount)
		case 4:
			rotationAngle -= rotationAmount
			redBox.transform = CGAffineTransform(rotationAngle: CGFloat(Double(rotationAngle) * Double.pi / 180))
		case 5:
			rotationAngle += rotationAmount
			redBox.transform = CGAffineTransform(rotationAngle: CGFloat(Double(rotationAngle) * Double.pi / 180))
		case 6:
			print("Increasing Height")
			redBox.bounds.size.height += CGFloat(changeAmount)
			redBox.bounds.size.width += CGFloat(changeAmount)
		case 7:
			print("Decreasing Height")
			redBox.bounds.size.height -= CGFloat(changeAmount)
			redBox.bounds.size.width -= CGFloat(changeAmount)
		default:
			print("default. ERROR")
		}
		borderLabel.bounds = redBox.frame
		borderLabel.center = redBox.center
		
		updateLabels()
		
	}
	
	
	func updateLabels() {
		let fOriginX = String(format: "%.1f", redBox.frame.origin.x)
		let fOriginY = String(format: "%.1f", redBox.frame.origin.y)
		let mCenterX = String(format: "%.1f", redBox.center.x)
		let mCenterY = String(format: "%.1f", redBox.center.y)
		let fSizeH = String(format: "%.1f", redBox.frame.size.height)
		let fSizeW = String(format: "%.1f", redBox.frame.size.width)
		
		
		let frameAttr: [NSAttributedString.Key: Any] = [
			.foregroundColor: frameColor
		]
		let boxAttr: [NSAttributedString.Key: Any] = [
			.foregroundColor: boxColor
		]
		
		
		var attrText = NSMutableAttributedString(string: "frame.origin .x:", attributes: frameAttr)
		attrText.append(NSAttributedString(string: "\(fOriginX) "))
		attrText.append(NSAttributedString(string: ".y:", attributes: frameAttr))
		attrText.append(NSAttributedString(string: "\(fOriginY)\n"))
		attrText.append(NSAttributedString(string: ".size.height:", attributes: frameAttr))
		attrText.append(NSAttributedString(string: "\(fSizeH) "))
		attrText.append(NSAttributedString(string: " .size.width:", attributes: frameAttr))
		attrText.append(NSAttributedString(string: "\(fSizeW)"))
		
		
		labelOne.attributedText = attrText
		labelOne.sizeToFit()
		
		attrText = NSMutableAttributedString(string: "redBox.center .x:", attributes: boxAttr)
		attrText.append(NSAttributedString(string: "\(mCenterX) "))
		attrText.append(NSAttributedString(string: " .y:", attributes: boxAttr))
		attrText.append(NSAttributedString(string: "\(mCenterY)"))
		
		labelTwo.attributedText = attrText
		labelTwo.sizeToFit()
		
		
		attrText = NSMutableAttributedString(string: "redBox.bounds .origin.x:", attributes: boxAttr)
		attrText.append(NSAttributedString(string: "\(redBox.bounds.origin.x) "))
		attrText.append(NSAttributedString(string: ".origin.y:", attributes: boxAttr))
		attrText.append(NSAttributedString(string: "\(redBox.bounds.origin.y)\n"))
		attrText.append(NSAttributedString(string: ".size.height:", attributes: boxAttr))
		attrText.append(NSAttributedString(string: "\(redBox.bounds.size.height) "))
		attrText.append(NSAttributedString(string: ".size.width:", attributes: boxAttr))
		attrText.append(NSAttributedString(string: "\(redBox.bounds.size.width)"))
		
		labelThree.attributedText = attrText
		labelThree.sizeToFit()
	}
	
}

extension NSAttributedString {
	static func + (_ lhs: NSAttributedString, _ rhs: NSAttributedString) -> NSAttributedString {
		let res = NSMutableAttributedString()
		res.append(lhs)
		res.append(rhs)
		return res
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
