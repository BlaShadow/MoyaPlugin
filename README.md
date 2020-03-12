# MoyaPlugin

Simple but effective and extensible Moya plugin for logging all HTTP responses, this repository was created to demonstrate how to create a custom plugin for moya but in the same way, to create an extensible plugin for login, I know moya already have a logging plugin in is does print so much info, and sometimes we just need a single line with a status and a URL.



## Plugin

````swift
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
````

The project it self is a example proejct, so if you want to download the project go for it and run it. It's a simple http call to `https://www.ipify.org/` to get your internet IP.
