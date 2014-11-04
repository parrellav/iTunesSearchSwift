//
//  ViewController.swift
//  iTunesSearchSwift
//
//  Created by Vincent Parrella on 11/4/14.
//  Copyright (c) 2014 Comcast. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ITunesSearchAPIProtocol {

    var api: ITunesSearchAPI = ITunesSearchAPI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        api.delegate = self;
        api.searchItunesFor("Jimmy Buffett")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func didRecieveResponse(results: NSDictionary) {
        println(results)
    }
}

