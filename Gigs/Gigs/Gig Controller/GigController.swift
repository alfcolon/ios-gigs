//
//  GigController.swift
//  Gigs
//
//  Created by alfredo on 1/20/20.
//  Copyright © 2020 Alfredo. All rights reserved.
//

import Foundation

class GigController{
    
    //MARK: - Properties
    
    let baseURL: URL = URL(string: "https://lambdagigs.vapor.cloud/api")!
    var bearer: Bearer? //used to present whether user is logged in or not
    var gigs: [Gig] = []
}
