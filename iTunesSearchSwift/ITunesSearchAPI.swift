//
//  ITunesSearchAPI.swift
//  iTunesSearchSwift
//
//  Created by Vincent Parrella on 11/4/14.
//  Copyright (c) 2014 Comcast. All rights reserved.
//

import UIKit

protocol ITunesSearchAPIProtocol {
    func didRecieveResponse(results: NSDictionary)
}

class ITunesSearchAPI: NSObject {
    
    var data: NSMutableData = NSMutableData()
    
    var delegate: ITunesSearchAPIProtocol?
    
    func searchItunesFor(searchTerm: String) {
        //Clean up the search terms by replacing spaces with +
        var itunesSearchTerm = searchTerm.stringByReplacingOccurrencesOfString(" ",
            withString: "+", options: NSStringCompareOptions.CaseInsensitiveSearch,
            range: nil)
        
        let escapedSearchTerm = itunesSearchTerm.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
        
        let urlPath = "https://itunes.apple.com/search?term=\(escapedSearchTerm)&media=music"
        //let urlPath: String = "https://itunes.apple.com/search?term=Jimmy+Buffett&media=music"
        var url: NSURL = NSURL(string: urlPath)!
        var request = NSURLRequest(URL: url)
        var connection: NSURLConnection = NSURLConnection(request: request, delegate: self,startImmediately: false)!
        
        println("Search iTunes API at URL \(url)")
        
        connection.start()
    }
    
    //NSURLConnection Connection failed
    func connection(connection: NSURLConnection!, didFailWithError error: NSError!) {
        println("Failed with error:\(error.localizedDescription)")
    }
    
    //New request so we need to clear the data object
    func connection(didReceiveResponse: NSURLConnection!, didReceiveResponse response:NSURLResponse!) {
        self.data = NSMutableData()
    }
    
    //Append incoming data
    func connection(connection: NSURLConnection!, didReceiveData data: NSData!) {
        self.data.appendData(data)
    }
    
    //NSURLConnection delegate function
    func connectionDidFinishLoading(connection: NSURLConnection!) {
        //Finished receiving data and convert it to a JSON object
        var jsonResult: NSDictionary = NSJSONSerialization.JSONObjectWithData(data,
            options:NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
        
        delegate?.didRecieveResponse(jsonResult)
    }
}
