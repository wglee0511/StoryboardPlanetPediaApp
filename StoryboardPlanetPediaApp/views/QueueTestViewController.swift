//
//  QueueTestViewController.swift
//  StoryboardPlanetPediaApp
//
//  Created by racoon on 7/3/24.
//

import UIKit

class QueueTestViewController: UIViewController {
    
    let firstOperation = OperationQueue()
    var isCancelled = false
    
    
    @IBAction func startOperation(_ sender: Any) {
        isCancelled = false
        
        firstOperation.addOperation {
            for _ in 1 ... 30 {
                guard !self.isCancelled else {
                    print("First Done")
                    return
                }
                print("🍏", separator: " ", terminator: " ")
                Thread.sleep(forTimeInterval: 0.3)
            }
        }
        
        let testOperation = BlockOperation {
            for _ in 1 ... 30 {
                guard !self.isCancelled else {
                    print("Second Done")
                    return
                }
                print("🍎", separator: " ", terminator: " ")
                Thread.sleep(forTimeInterval: 0.5)
            }
        }
        
        firstOperation.addOperation(testOperation)
        
        let secondOperation = CustomOperation(type: "🍇")
        
        firstOperation.addOperation(secondOperation)
        
        secondOperation.completionBlock = {
            print("Complete")
        }
        
    }
    

    @IBAction func cancelOperation(_ sender: Any) {
        isCancelled = true
        firstOperation.cancelAllOperations()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
