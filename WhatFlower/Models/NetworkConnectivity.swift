//
//  NetworkConnectivity.swift
//  WhatFlower
//
//  Created by Jesse Anderson on 9/19/18.
//  Copyright © 2018 Jesse Anderson. All rights reserved.
//

import Foundation
import UIKit


class WikiCalls {
    
    func makeWikiRequestfor(flowerName: String) -> (flowerName: String, image: UIImage) {
        let baseURL = "https://en.wikipedia.org/w/api.php?"
        
        let actionQuery = "action=query"
        
        var flowerName = String()
        var image = UIImage()
        
        return (flowerName, image)
    }
    
}
