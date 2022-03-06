//
//  ViewController.swift
//  CatchTheFin
//
//  Created by Sinan Mente on 25.02.2022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var timelbl: UILabel!
    @IBOutlet weak var scorelbl: UILabel!
    @IBOutlet weak var highscorelbl: UILabel!
    @IBOutlet weak var fino1: UIImageView!
    @IBOutlet weak var fino2: UIImageView!
    @IBOutlet weak var fino3: UIImageView!
    @IBOutlet weak var fino4: UIImageView!
    @IBOutlet weak var fino5: UIImageView!
    @IBOutlet weak var fino6: UIImageView!
    @IBOutlet weak var fino7: UIImageView!
    @IBOutlet weak var fino8: UIImageView!
    @IBOutlet weak var fino9: UIImageView!
    
    var score = 0
    var timer = Timer()
    var hidefintimer = Timer()
    var counter = 0
    var finoArr = [UIImageView]()
    var highScore = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        scorelbl.text = "Score: \(score)"
        
        let storedHighScore = UserDefaults.standard.object(forKey: "hscore")
        
        if storedHighScore == nil {
            highScore = 0
            highscorelbl.text = "Highscore: \(highScore)"
        }
        
        if let newHighScore = storedHighScore as? Int {
            highScore = newHighScore
            highscorelbl.text = "HighScore: \(highScore)"
        }
        
        fino1.isUserInteractionEnabled = true
        fino2.isUserInteractionEnabled = true
        fino3.isUserInteractionEnabled = true
        fino4.isUserInteractionEnabled = true
        fino5.isUserInteractionEnabled = true
        fino6.isUserInteractionEnabled = true
        fino7.isUserInteractionEnabled = true
        fino8.isUserInteractionEnabled = true
        fino9.isUserInteractionEnabled = true
        
        let rc1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let rc2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let rc3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let rc4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let rc5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let rc6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let rc7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let rc8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let rc9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        fino1.addGestureRecognizer(rc1)
        fino2.addGestureRecognizer(rc2)
        fino3.addGestureRecognizer(rc3)
        fino4.addGestureRecognizer(rc4)
        fino5.addGestureRecognizer(rc5)
        fino6.addGestureRecognizer(rc6)
        fino7.addGestureRecognizer(rc7)
        fino8.addGestureRecognizer(rc8)
        fino9.addGestureRecognizer(rc9)
        
        finoArr = [fino1, fino2, fino3, fino4, fino5, fino6, fino7, fino8, fino9]
        
        
        counter = 10
        timelbl.text = String(counter)
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        hidefintimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideFino), userInfo: nil, repeats: true)
        
        hideFino()
        
    }
    
    @objc func hideFino () {
        
        for fin in finoArr {
            fin.isHidden = true
        }
       let random = Int(arc4random_uniform(UInt32(finoArr.count - 1)))
        finoArr[random].isHidden = false
        
    }
    
    
        
    @objc func increaseScore () {
        score += 1
        scorelbl.text = String(score)
        
    }
    @objc func countDown () {
        counter -= 1
        timelbl.text = String(counter)
        
        if counter == 0 {
            timer.invalidate()
            hidefintimer.invalidate()
            
            for fin in finoArr {
                fin.isHidden = true
            }
            
            if self.score > highScore {
                self.highScore = self.score
                highscorelbl.text = "Highscore: \(self.highScore)"
                UserDefaults.standard.set(self.highScore, forKey: "hscore")
            }
            
             
            let alert = UIAlertController(title: "Time's Up", message: "Do you want to play again", preferredStyle: UIAlertController.Style.alert)
            let nobtn = UIAlertAction(title: "NO", style: UIAlertAction.Style.cancel, handler: nil)
            let yesbtn = UIAlertAction(title: "YES", style: UIAlertAction.Style.default) { UIAlertAction in
                //Function
                self.score = 0
                self.scorelbl.text = "Score: \(self.score)"
                self.counter = 10
                self.timelbl.text = String(self.counter)
                
                self.timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                self.hidefintimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideFino), userInfo: nil, repeats: true)
                
            }
            
            alert.addAction(nobtn)
            alert.addAction(yesbtn)
            self.present(alert, animated: true, completion: nil)
            
        }
    }
}

