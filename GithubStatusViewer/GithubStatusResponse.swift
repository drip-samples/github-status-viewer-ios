//
//  GithubStatusResponse.swift
//  GithubStatusViewer
//
//  Created by ogawa_mitsunori on 2019/08/15.
//  Copyright © 2019 ogawa_mitsunori. All rights reserved.
//

import Foundation
import APIKit

struct GithubStatusResponse: Decodable {
    let status: Status
    
    struct Status: Decodable {
        let description: String
        let indicator: String
    }
}
