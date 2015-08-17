//
//  ViewController.swift
//  Pod Error Framework
//
//  Created by Silas Knobel on 17/08/15.
//  Copyright (c) 2015 katun.ch. All rights reserved.
//

import UIKit
import PodErrorKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let something = Utils.doSomething()
        debugPrintln(something)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func requestContactsAccess(sender: AnyObject?) {
        Utils.requestContactsAccess { (granted) -> Void in
            let message = granted ? "Access Granted" : "Access denied"
            let alert = UIAlertController(title: "Contacts", message: message, preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (alertAction) -> Void in
                
            }))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
}

