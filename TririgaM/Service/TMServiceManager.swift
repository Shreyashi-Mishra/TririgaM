//
//  TMServiceManager.swift
//
//  Created by Kondaiah on 16/10/19.
//  Copyright © 2019 Kondaiah Veeraboyina. All rights reserved.
//

import UIKit

// if any error code existed in response at any APIs calling time.
// we will get kNotify_ErrorCodes notification.
let kNotify_ErrorCodes = Notification.Name("Notify_ErrorCodes")


// base class...
class TMServiceManager: NSObject {
    
    // instance
    static let shared = TMServiceManager()
    // assign basic url path (ex: x.x.x.x/index.php)
    var basicURL = String()
    // assign request headers as key and values
    var headers: [String: String] = [:]
    // init for instance
    private override init() {}
}


extension TMServiceManager {
    
    //
    // convert json sting to object
    static func getObject(jsonString: String) -> Any {
        
        // convert string into data...
        if let dateObj = jsonString.data(using: String.Encoding.utf8) {
            do {
                // data convert into any object...
                let finalObj = try JSONSerialization.jsonObject(with: dateObj, options: []) as Any
                return finalObj
            } catch let error as NSError {
                print("Json string to object failed : \(error.localizedDescription)")
            }
        }
        return ""
    }
    
    //
    // convert object to json sting
    static func getJSONString(object: Any) -> String {
        
        // if object is already string...
        if object is String {
            return object as! String
        }
        do {
            // convert object into data...
            let jsonData = try JSONSerialization.data(withJSONObject: object, options: [])
            
            // getting jsonString...
            let stringObj = String(data: jsonData, encoding: .utf8)
            return stringObj!
        } catch let error as NSError {
            print("Json object to string failed : \(error.localizedDescription)")
        }
        return ""
    }
}

extension TMServiceManager {
    
    //
    // Parameters:- request body as weburl formate
    // - file: file name after the base_url
    // - httpMethod: GET, POST, PUT, DELETE (Ex: .GET)
    // - handler: we will get -result Object, -success state, -error, -data
    //
    //
    func requestWith(file: String,
                     httpMethod: TMHTTPMethod,
                     handler: @escaping CompletionHandler) -> Void {
        
        // generating url...
        let urlString = "\(basicURL)/\(file)"
        var url_final: URL?
        if let encoded = urlString.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed), let url = URL(string: encoded) {
            url_final = url
        }
        else {
            handler(nil, false, nil, nil)
            return
        }
        
        // get request...
        let request = TMAPIsClient().getRequest(url: url_final!, httpMethod: httpMethod)
        print("URL :-> \(httpMethod.rawValue) : \(urlString)")
        
        
        // calling apis...
        let task = TMAPIsClient.sessionConfiguration().dataTask(with: request)
        { [weak self] (data, response, error) in
            
            // final response getting...
            if error != nil {
                handler(nil, false, error as NSError?, data)
            } else {
                do {
                    let result = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                    self?.sessionOrTokenExpiryCodes(result_obj: result)
                    handler(result, true, error as NSError?, data)
                } catch {
                    print("\(String(describing: response?.url)) : \(String(decoding: data ?? Data(), as: UTF8.self))")
                    handler(nil, false, error as NSError?, data)
                }
            }
        }
        task.resume()
    }
    
    //
    // Parameters:- request body as weburl formate
    // - params: assign like key and value
    // - file: file name after the base_url
    // - httpMethod: GET, POST, PUT, DELETE (Ex: .GET)
    // - handler: we will get -result Object, -success state, -error, -data
    //
    //
    func requestWith(params: [String: String]?,
                     file: String,
                     httpMethod: TMHTTPMethod,
                     handler: @escaping CompletionHandler) -> Void {
        
        // generating url...
        let urlString = "\(basicURL)/\(file)?\(TMAPIsClient().getParamString(params: params))"
        var url_final: URL?
        if let encoded = urlString.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed), let url = URL(string: encoded) {
            url_final = url
        }
        else {
            handler(nil, false, nil, nil)
            return
        }
        
        // get request...
        let request = TMAPIsClient().getRequest(url: url_final!, httpMethod: httpMethod)
        print("URL :-> \(httpMethod.rawValue) : \(urlString)")
        
        
        // calling apis...
        let task = TMAPIsClient.sessionConfiguration().dataTask(with: request)
        { [weak self] (data, response, error) in
            
            // final response getting...
            if error != nil {
                handler(nil, false, error as NSError?, data)
            } else {
                do {
                    let result = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                    self?.sessionOrTokenExpiryCodes(result_obj: result)
                    handler(result, true, error as NSError?, data)
                } catch {
                    print("\(String(describing: response?.url)) : \(String(decoding: data ?? Data(), as: UTF8.self))")
                    handler(nil, false, error as NSError?, data)
                }
            }
        }
        task.resume()
    }
    
    //
    // Parameters:- request body as RAW formate
    // - params: assign like key and value
    // - file: file name after the base_url
    // - httpMethod: GET, POST, PUT, DELETE (Ex: .PUT)
    // - handler: we will get -result Object, -success state, -error, -data
    //
    //
    func requestWithRaw(params: [String: String],
                        file: String,
                        httpMethod: TMHTTPMethod,
                        handler: @escaping CompletionHandler) -> Void {
        
        // generate rquest body...
        let jsonData = try! JSONSerialization.data(withJSONObject: params, options: [])
        print("Raw : \(params)")
        
        // get request...
        let urlString = "\(basicURL)/\(file)"
        let request = TMAPIsClient().getRequestRaw(url: URL.init(string: urlString)!,
                                                   httpMethod: httpMethod,
                                                   httpBody: jsonData as Data)
        print("URL :-> \(httpMethod.rawValue) : \(urlString)")
        
        
        // calling apis...
        let task = TMAPIsClient.sessionConfiguration().dataTask(with: request)
        { [weak self] (data, response, error) in
            
            // final response getting...
            if error != nil {
                handler(nil, false, error as NSError?, data)
            } else {
                do {
                    let result = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                    self?.sessionOrTokenExpiryCodes(result_obj: result)
                    handler(result, true, error as NSError?, data)
                } catch {
                    print("\(String(describing: response?.url)) : \(String(decoding: data ?? Data(), as: UTF8.self))")
                    handler(nil, false, error as NSError?, data)
                }
            }
        }
        task.resume()
    }
    
    //
    // Parameters:- request body as x-www-form-urlencoded formate
    // - params: assign like key and value
    // - file: file name after the base_url
    // - httpMethod: GET, POST, PUT, DELETE (Ex: .POST)
    // - handler: we will get -result Object, -success state, -error, -data
    //
    //
    func requestWithXwwwform(params: [String: String],
                             file: String,
                             httpMethod: TMHTTPMethod,
                             handler: @escaping CompletionHandler) -> Void {
        
        // generate rquest body...
        let requestString = TMAPIsClient().getParamString(params: params)
        let postData = requestString.data(using: .utf8, allowLossyConversion: false)!
        print("X-www-form : \(requestString)")
        
        // get request...
        let urlString = "\(basicURL)/\(file)"
        let request = TMAPIsClient().getRequestXwwwform(url: URL.init(string: urlString)!,
                                                        httpMethod: httpMethod,
                                                        httpBody: postData as Data)
        print("URL :-> \(httpMethod.rawValue) : \(urlString)")
        
        
        // calling apis...
        let task = TMAPIsClient.sessionConfiguration().dataTask(with: request)
        { [weak self] (data, response, error) in
            
            // final response getting...
            if error != nil {
                handler(nil, false, error as NSError?, data)
            } else {
                do {
                    let result = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                    self?.sessionOrTokenExpiryCodes(result_obj: result)
                    handler(result, true, error as NSError?, data)
                } catch {
                    print("\(String(describing: response?.url)) : \(String(decoding: data ?? Data(), as: UTF8.self))")
                    handler(nil, false, error as NSError?, data)
                }
            }
        }
        task.resume()
    }
    
    //
    // Parameters:- request body as form-data formate
    // - params: assign like key and value
    // - file: file name after the base_url
    // - httpMethod: GET, POST, PUT, DELETE (Ex: .POST)
    // - handler: we will get -result Object, -success state, -error, -data
    //
    //
    func requestWithFormdata(params: [String: String]?,
                             file: String,
                             httpMethod: TMHTTPMethod,
                             handler: @escaping CompletionHandler) -> Void {
        
        // get request...
        let urlString = "\(basicURL)/\(file)"
        let request = TMAPIsClient().getRequestFormdata(url: URL.init(string: urlString)!,
                                                        httpMethod: httpMethod,
                                                        httpBody: getDatafrom(params: params, media: nil))
        print("URL :-> \(httpMethod.rawValue) : \(urlString)")
        
        
        // calling apis...
        let task = TMAPIsClient.sessionConfiguration().dataTask(with: request)
        { [weak self] (data, response, error) in
            
            // final response getting...
            if error != nil {
                handler(nil, false, error as NSError?, data)
            } else {
                do {
                    let result = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                    self?.sessionOrTokenExpiryCodes(result_obj: result)
                    handler(result, true, error as NSError?, data)
                } catch {
                    print("\(String(describing: response?.url)) : \(String(decoding: data ?? Data(), as: UTF8.self))")
                    handler(nil, false, error as NSError?, data)
                }
            }
        }
        task.resume()
    }
    
    //
    // Parameters:- request body as form-data formate
    // - params: assign like key and value
    // - media: assign like key and value(UIImage) formate
    // - file: file name after the base_url
    // - httpMethod: GET, POST, PUT, DELETE (Ex: .POST)
    // - handler: we will get -result Object, -success state, -error, -data
    //
    //
    func requestWithFormdata(params: [String: String]?,
                             media: [TMMedia]?,
                             file: String,
                             httpMethod: TMHTTPMethod,
                             handler: @escaping CompletionHandler) -> Void {
        
        // get request...
        let urlString = "\(basicURL)/\(file)"
        let request = TMAPIsClient().getRequestFormdata(url: URL.init(string: urlString)!,
                                                        httpMethod: httpMethod,
                                                        httpBody: getDatafrom(params: params, media: media))
        print("URL :-> \(httpMethod.rawValue) : \(urlString)")
        
        
        // calling apis...
        let task = TMAPIsClient.sessionConfiguration().dataTask(with: request)
        { [weak self] (data, response, error) in
            
            // final response getting...
            if error != nil {
                handler(nil, false, error as NSError?, data)
            } else {
                do {
                    let result = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                    self?.sessionOrTokenExpiryCodes(result_obj: result)
                    handler(result, true, error as NSError?, data)
                } catch {
                    print("\(String(describing: response?.url)) : \(String(decoding: data ?? Data(), as: UTF8.self))")
                    handler(nil, false, error as NSError?, data)
                }
            }
        }
        task.resume()
    }
}


extension TMServiceManager {
    
    private func getDatafrom(params: [String: String]?, media: [TMMedia]?) -> Data {
        
        // boundary...
        let boundary = TMAPIsClient().getBoundary()
        var body = Data()
        
        // create form data...
        if params != nil {
            for (key, value) in params! {
                
                // form data with parameters...
                body.append(string: "--\(boundary)\r\n")
                body.append(string: "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.append(string: "\(value)\r\n")
                
                print("\(key) : \(value)")
            }
        }
        
        if media != nil {
            for media_obj in media! {
                
                // form data with media file...
                body.append(string: "--\(boundary)\r\n")
                body.append(string: "Content-Disposition: form-data; name=\"\(media_obj.key)\"; filename=\"\(media_obj.name)\"\r\n")
                body.append(string: "Content-Type: \(media_obj.mimetype)\r\n\r\n")
                body.append(media_obj.data)
                body.append(string: "\r\n")
                
                print("\(media_obj.key) : \(media_obj.name)")
            }
        }
        
        body.append(string: "--\(boundary)--\r\n")
        return body
    }
    
    //
    // Error code checking if its existed in the list notify-error code
    //
    private func sessionOrTokenExpiryCodes(result_obj: Any) {
        if let result_dict = result_obj as? [String: Any] {
            
            // error code is number...
            if let error_code = result_dict["error"] {
                NotificationCenter.default.post(name: kNotify_ErrorCodes, object: "\(error_code)", userInfo: nil)
            }
        }
    }
}



// typealias declaration...
typealias CompletionHandler = (_ resultObject: Any?, _ success: Bool, _ error: Error?, _ data: Data?) -> Void
typealias TMHTTPMethod = TMAPIsClient.HTTPMethod

class TMAPIsClient: NSObject {
    
    // httpMethod types...
    enum HTTPMethod: String {
        
        case GET = "GET"
        case POST = "POST"
        case PUT = "PUT"
        case DELETE = "DELETE"
        case UPDATE = "UPDATE"
               
        case HEAD = "HEAD"
        case CONNECT = "CONNECT"
        case OPTIONS = "OPTIONS"
        case TRACE = "TRACE"
    }

    static func sessionConfiguration() -> URLSession {
        
        // configuration session...
        let defaultConfigur = URLSessionConfiguration.default
        let defaultSession = URLSession.init(configuration: defaultConfigur,
                                             delegate: nil,
                                             delegateQueue: OperationQueue.main)
        return defaultSession
    }
    
    func getHeaders(requests: URLRequest) -> URLRequest {
        
        // adding headers...
        var request = requests as URLRequest
        for (key, value) in TMServiceManager.shared.headers {
            request.addValue(value, forHTTPHeaderField: key)
        }
        return request
    }
    
    func getParamString(params: [String: String]?) -> String {
        
        // getting params string...
        var requestString = ""
        if params != nil {
            for (key, value) in params! {
                if requestString.count == 0 {
                    requestString = "\(key)=\(value)"
                } else {
                    requestString = "\(requestString)&\(key)=\(value)"
                }
            }
        }
        return requestString
    }
    
    func getBoundary() -> String {
        return "Boundary-\(UUID().uuidString)" //"---------------------------14737809831466499882746641449"
    }
}

extension TMAPIsClient {
    
    func getRequest(url: URL, httpMethod: TMHTTPMethod) -> URLRequest {
        
        // generate request...
        var request = URLRequest.init(url: url)
        request.httpMethod = httpMethod.rawValue
        return getHeaders(requests: request)
    }
    
    func getRequestRaw(url: URL, httpMethod: TMHTTPMethod, httpBody: Data) -> URLRequest {
        
        // generate request...
        var request = URLRequest.init(url: url)
        request.httpMethod = httpMethod.rawValue
        request.httpBody = httpBody
        request.addValue("application/json",
                         forHTTPHeaderField: "Content-Type")
        request.addValue("application/json",
                         forHTTPHeaderField: "Accept")
        return getHeaders(requests: request)
    }
    
    func getRequestXwwwform(url: URL, httpMethod: TMHTTPMethod, httpBody: Data) -> URLRequest {
        
        // generate request...
        var request = URLRequest.init(url: url)
        request.httpMethod = httpMethod.rawValue
        request.httpBody = httpBody
        request.addValue(String(describing: httpBody.count),
                         forHTTPHeaderField: "Content-Length")
        request.addValue("application/x-www-form-urlencoded charset=utf-8",
                         forHTTPHeaderField: "Content-Type")
        request.addValue("application/x-www-form-urlencoded charset=utf-8",
                         forHTTPHeaderField: "Accept")
        return getHeaders(requests: request)
    }
    
    func getRequestFormdata(url: URL, httpMethod: TMHTTPMethod, httpBody: Data) -> URLRequest {
        
        // generate request...
        let boundary = getBoundary()
        let contentType = "multipart/form-data; boundary=\(boundary)"
        
        // generate request...
        var request = URLRequest.init(url: url)
        request.httpMethod = httpMethod.rawValue
        request.httpBody = httpBody
        request.addValue(contentType as String, forHTTPHeaderField: "Content-Type")
        return getHeaders(requests: request)
    }
}



// appending string...
extension Data {
    mutating func append(string: String) {
        let data = string.data(using: String.Encoding.utf8,
                               allowLossyConversion: true)
        append(data!)
    }
}



struct TMMedia {
    
    // variables...
    let key: String
    let name: String
    let mimetype: String
    let data: Data
    
    // media with image
    init?(key: String, name: String, image: UIImage) {
        
        self.key = key
        self.name = name
        self.mimetype = "image/jpg"
        guard let data = image.jpegData(compressionQuality: 0.5) else {
            return nil
        }
        self.data = data
    }
    
    // media with video
    init(key: String, name: String, mimetype: String, video: Data) {
        
        self.key = key
        self.name = name
        self.mimetype = mimetype
        self.data = video
    }
    
    // media with audio
    init(key: String, name: String, mimetype: String, audio: Data) {
        
        self.key = key
        self.name = name
        self.mimetype = mimetype
        self.data = audio
    }
}
