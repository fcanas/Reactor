//
//  ViewController.swift
//  Reactor
//
//  Created by Fabian Canas on 5/2/15.
//  Copyright (c) 2015 Fabián Cañas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let textView = ACEView()
    //UITextView()
    let reactView = RCTRootView(bundleURL: NSBundle.mainBundle().URLForResource("main", withExtension: "jsbundle"), moduleName: "Base", launchOptions: nil)
    var bundleURLs :[NSURL!] = [NSBundle.mainBundle().URLForResource("main", withExtension: "jsbundle"), NSBundle.mainBundle().URLForResource("alt", withExtension: "jsbundle")]
    var currentBundleURL = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        view.setTranslatesAutoresizingMaskIntoConstraints(false)
        textView.setTranslatesAutoresizingMaskIntoConstraints(false)
        reactView.setTranslatesAutoresizingMaskIntoConstraints(false)
        
//        CodeEditBehavior.addToTextView(textView)
        
        view.addSubview(textView)
        view.addSubview(reactView)
        
        reactView.backgroundColor = .magentaColor()
        
        let bindings = [
            "textView" : textView,
            "reactView" : reactView
        ]
        let horizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|[textView][reactView(==320)]|", options: .allZeros, metrics: nil, views: bindings)
        let verticalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|[textView(==reactView)]|", options: .allZeros, metrics: nil, views: bindings)
        
        let c = [horizontalConstraints, verticalConstraints].flatMap({ e in e })
        view.addConstraints(c)
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
        currentBundleURL++
        currentBundleURL %= count(bundleURLs)
        
        self.reactView.bridge.bundleURL = bundleURLs[currentBundleURL]
        self.reactView.bridge.reload()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

