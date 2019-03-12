//
//  ViewController.swift
//  CoreMootionTesting
//
//  Created by Marcus Thuvesen on 2019-03-11.
//  Copyright © 2019 Marcus Thuvesen. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {

    let motionManager = CMMotionManager()
    
    @IBOutlet weak var jumpLabel: UILabel!
    @IBOutlet weak var xLabel: UILabel!
    @IBOutlet weak var yLabel: UILabel!
    @IBOutlet weak var zLabel: UILabel!
    @IBOutlet weak var zeroJumps: UIButton!
    @IBOutlet weak var toGyro: UIButton!
    
    let jumpLimit = 0.7
    var totalJumps = 0
    var jumpUpAndDown = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        toGyro.layer.cornerRadius = 15
        zeroJumps.layer.cornerRadius = 15
        
        if motionManager.isDeviceMotionAvailable{
            startAccelerometer()
        }
        
    }

    
    func startAccelerometer(){
        
       
        motionManager.deviceMotionUpdateInterval = 0.1
        motionManager.startDeviceMotionUpdates(to: .main) { (motion, error) in
          //print(data)
            if let motion = motion{
                
                
                var x = motion.userAcceleration.x
                var y = motion.userAcceleration.y
                var z = motion.userAcceleration.z
                
                x = round(100 * x) / 100
                y = round(100 * y) / 100
                z = round(100 * z) / 100
                
                if x.isZero && x.sign == .minus {
                    x = 0.0
                }
                
                if y.isZero && y.sign == .minus {
                    y = 0.0
                }
                
                if z.isZero && z.sign == .minus {
                    z = 0.0
                }
                
                
                if y > self.jumpLimit {
                    
                    print("y")
                    self.jumpUpAndDown += 1
                    
                    if self.jumpUpAndDown == 2{
                        self.totalJumps = self.totalJumps + 1
                        self.jumpLabel.text = "Du har hoppat " + "\(self.totalJumps) hopp"
                        self.jumpUpAndDown = 0
                    }
                }
                else if x > self.jumpLimit{
                    print("x")
                    self.jumpUpAndDown += 1

                    if self.jumpUpAndDown == 2{
                        self.totalJumps = self.totalJumps + 1
                        self.jumpLabel.text = "Du har hoppat " + "\(self.totalJumps) hopp"
                        self.jumpUpAndDown = 0
                    }
                }
                else if z > self.jumpLimit{
                    print("z")
                    self.jumpUpAndDown += 1
                    
                    if self.jumpUpAndDown == 2{
                        self.totalJumps = self.totalJumps + 1
                        self.jumpLabel.text = "Du har hoppat " + "\(self.totalJumps) hopp"
                        self.jumpUpAndDown = 0
                    }
                }
                
                self.xLabel.text = "\(x)"
                self.yLabel.text = "\(y)"
                self.zLabel.text = "\(z)"
                
            }
        }
            
    }
    
    @IBAction func zeroJumpsBtn(_ sender: UIButton) {
        totalJumps = 0
        self.jumpLabel.text = "Du har hoppat " + "\(self.totalJumps) hopp"
    }
    
    
    @IBAction func toGyroBtn(_ sender: UIButton) {
        
    }
    
    
}

