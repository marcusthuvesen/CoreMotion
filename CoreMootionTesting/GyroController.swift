//
//  GyroController.swift
//  CoreMootionTesting
//
//  Created by Marcus Thuvesen on 2019-03-12.
//  Copyright © 2019 Marcus Thuvesen. All rights reserved.
//

import UIKit
import CoreMotion
class GyroController: UIViewController {

    let motionManager = CMMotionManager()
    
    @IBOutlet weak var xLabelGyro: UILabel!
    @IBOutlet weak var yLabelGyro: UILabel!
    @IBOutlet weak var zLabelGyro: UILabel!
    @IBOutlet weak var gyroLabel: UILabel!
    
    
    @IBOutlet weak var zeroPoints: UIButton!
    @IBOutlet weak var goToAccelerometer: UIButton!
    
    
    var points = 0
    var leftSide = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        goToAccelerometer.layer.cornerRadius = 15
        zeroPoints.layer.cornerRadius = 15
        gyroTracker()
    }
    
    func gyroTracker(){
        
        motionManager.deviceMotionUpdateInterval = 0.15
        if let operationQueue = OperationQueue.current{
            motionManager.startDeviceMotionUpdates(to: operationQueue){(data, error) in
                print(data as Any)
                if let motion = data{
                    
                    
                
                    let x = round(motion.attitude.roll * 100) / 100
                    let y = round(motion.attitude.pitch * 100) / 100
                    let z = round(motion.attitude.yaw * 100) / 100
                    
                    
                    self.xLabelGyro.text = String(x)
                    self.yLabelGyro.text = String(y)
                    self.zLabelGyro.text = String(z)
                    
                    
                    
                    if (y > 0.2 && self.leftSide == true) || (y < -0.2 && self.leftSide == false) {
                        self.leftSide = !self.leftSide
                        self.points += 5
                        self.gyroLabel.text = "Poäng = \(self.points)"
                    }
                    
                }
                
                
            }
        }
    }
    
    
    
    @IBAction func zeroPoints(_ sender: UIButton) {
        points = 0
        self.gyroLabel.text = "Du har hoppat " + "\(points) hopp"
    }
    
}
