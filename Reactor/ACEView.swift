//
//  ACEView.swift
//  Reactor
//
//  Created by Fabian Canas on 5/5/15.
//  Copyright (c) 2015 Fabián Cañas. All rights reserved.
//

import UIKit

class ACEView: UIWebView, UIWebViewDelegate {
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    func commonInit() {
        self.delegate = self
        
        let html = NSString(contentsOfURL: NSBundle.mainBundle().URLForResource("Editor", withExtension: "html")!, encoding: NSUTF8StringEncoding, error: nil) as String?
        let aceURL = NSBundle.mainBundle().resourceURL?.URLByAppendingPathComponent("ace")
        println(aceURL)
        loadHTMLString(html, baseURL: aceURL)
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
