//
//  GithubStatusRequest.swift
//  GithubStatusViewer
//
//  Created by ogawa_mitsunori on 2019/08/15.
//  Copyright © 2019 ogawa_mitsunori. All rights reserved.
//

import APIKit

struct GithubStatusRequest: Request {
    typealias Response = GithubStatusResponse
    
    var baseURL: URL {
        return URL(string: "https://kctbh9vrtdwd.statuspage.io")!
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var path: String {
        return "/api/v2/status.json"
    }
    
    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> GithubStatusResponse {
        if let data = object as? Data {
            return try decodeResponse(data: data)
            
        } else if let dic = object as? [String : AnyObject] {
            let data = try! JSONSerialization.data(withJSONObject: dic, options: [])
            return try decodeResponse(data: data)
            
        } else {
            throw ResponseError.unexpectedObject(object)
        }
    }
    
    func decodeResponse(data: Data) throws -> GithubStatusResponse {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        return try jsonDecoder.decode(GithubStatusResponse.self, from: data)
    }
}
