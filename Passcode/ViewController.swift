//
//  ViewController.swift
//  Passcode
//
//  Created by Kyle Lei on 2021/11/24.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet var passcodeImageViews: [UIImageView]!
    @IBOutlet weak var lockImageView: UIImageView!
    @IBOutlet var keyButtons: [UIButton]!
    @IBOutlet weak var footerLabel: UILabel!
    @IBOutlet weak var passcodeLabel: UILabel!
    
    var passcode = "1984"
    var entercode = ""
        
    func changeImage() {
        let codeCount = entercode.count
        
        switch codeCount {
        case 1...3:
            passcodeImageViews[codeCount-1].isHighlighted = true
            passcodeImageViews[codeCount].isHighlighted = false
        case 4:
            passcodeImageViews[codeCount-1].isHighlighted = true
        default:
            for passcodeImageView in passcodeImageViews {
                passcodeImageView.isHighlighted = false
            }
        }
    }
    
    
    let screen = UIScreen.main.bounds
    func background(){
        let gradient = CAGradientLayer()
        gradient.frame = CGRect(x: 0, y: 0, width: screen.width , height: screen.height)
        gradient.type = .radial
        gradient.colors = [UIColor.white.cgColor, UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0).cgColor]
        gradient.startPoint = CGPoint(x: 0.5, y: 0.5)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        gradient.zPosition = -1
        view.layer.addSublayer(gradient)
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        background()
        
    }
    
    @IBAction func enterCode(_ sender: UIButton) {
        //輸入密碼數量少於4允許輸入
        if entercode.count < 4 {
            if let inputNum = sender.currentTitle {
                entercode.append(inputNum)
            }
        }
        //輸入密碼數量等於4判斷正確或錯誤
        if entercode.count == 4 {
            //輸入正確密碼鎖圖片會顯示解鎖
            if entercode == passcode {
                for passcodeImageView in passcodeImageViews {
                    passcodeImageView.isHidden = true
                }
                for button in keyButtons {
                    button.isHidden = true
                }
                footerLabel.isHidden = true
                passcodeLabel.text = "Welcome"
                lockImageView.isHighlighted = true
                entercode = ""
            //輸入錯誤密碼圖示會晃動
            }else{
                for passcodeImageView in passcodeImageViews {
                    passcodeImageView.shake()
                }
                entercode = ""
            }
        }
        changeImage()
    }
        
    @IBAction func deleteCode(_ sender: UIButton) {
                
        if entercode.count != 0 {
            entercode = String(entercode.dropLast(1))
        }
        changeImage()
    }
    
    @IBAction func faceLogin(_ sender: UIButton) {
        let alertController = UIAlertController(title: "敬請期待", message: "人臉辨識尚未開發完成！", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
       present(alertController, animated: true, completion: nil)
    }
}



extension UIView {
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: .linear)
        animation.duration = 0.6
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
}
