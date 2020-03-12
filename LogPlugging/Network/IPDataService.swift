//
//  IPDataService.swift
//  LogPlugging
//
//  Created by Luis Romero on 3/11/20.
//  Copyright © 2020 Luis Romero. All rights reserved.
//

import Moya

class LogPlugin: PluginType {
  let customFormatter: ((_ response: Response) -> String)
  
  init(with formatter: ((_ response: Response) -> String)? = nil) {
    if let formatter = formatter {
      customFormatter = formatter
    } else {
      customFormatter = LogPlugin.defaultFormatter
    }
  }

  private class func defaultFormatter(response: Response) -> String {
    return "✅ \(response.statusCode): \(response.request?.url?.absoluteString ?? "")"
  }

  func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
    switch result {
    case .success(let response):
      print(customFormatter(response))
    case .failure(let error):
      print("🔥 Fail request", error.errorDescription ?? "")
    }
  }
}

class IPDataService: NSObject {
  private let service: MoyaProvider<IPService>
  
  override init() {
    service = MoyaProvider<IPService>(plugins: [LogPlugin()])
  }
  
  func myIp(with completion: @escaping (_ ip: String?, _ error: String?) -> Void) {
    service.request(.myIp) { (result) in
      switch result {
      case .success(let response):
        do {
          let json = try JSONSerialization.jsonObject(with: response.data, options: []) as? [String : Any]

          completion(json?["ip"] as? String, nil)
        } catch {
          print("Error catch", error)
          completion(nil, error.localizedDescription)
        }
      case .failure(let error):
        completion(nil, error.localizedDescription)
      }
    }
  }
}
