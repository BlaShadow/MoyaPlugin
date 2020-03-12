//
//  IPService.swift
//  LogPlugging
//
//  Created by Luis Romero on 3/11/20.
//  Copyright © 2020 Luis Romero. All rights reserved.
//

import Moya

enum IPService {
  case myIp
}

extension IPService: TargetType {
  var baseURL: URL {
    return URL(string: "https://api.ipify.org")!
  }
  
  var path: String {
    return ""
  }
  
  var method: Method {
    return .get
  }
  
  var sampleData: Data {
    return Data()
  }
  
  var task: Task {
    return .requestParameters(parameters: ["format": "json"], encoding: URLEncoding.queryString)
  }
  
  var headers: [String : String]? {
    return [:]
  }
}
