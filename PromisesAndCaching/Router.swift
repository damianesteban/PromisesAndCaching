//
//  Router.swift
//  PromisesAndCaching
//
//  Created by Damian Esteban on 2/11/17.
//  Copyright © 2017 Damian Esteban. All rights reserved.
//

import Foundation
import Cache
import RNCryptor
import then
import Decodable

let cache = NSCache<AnyObject, AnyObject>()

typealias JSONDictionary = [String: Any]
// Resource Error
enum ResourceError: Error {
    case invalidBaseURL
}

// Errors for NetworkService
enum NetworkServiceError: Error {
    case decodeJSONError
    case statusError(status: Int)
    case otherError(Error)
}

// enum for HTTPMethod
enum Method: String {
    case get = "GET"
}

/// A Resource - contains the bar minimum needed for a request.
protocol Resource {
    var method: Method { get }
    var path: String { get }
    var parameters: [String: String] { get }
}

/// Resource Extension - provides default implementation of `method` and helper method to create URLRequest
extension Resource {
    
    var method: Method {
        return .get
    }
    
    // Creates a URLRequest from the method, parameters and path.
    func requestWithBaseURL(baseURL: URL) -> URLRequest {
        let URL = baseURL.appendingPathComponent(path)
        
        // NSURLComponents can fail due to programming errors, so
        // prefer crashing than returning an optional
        
        guard var components = URLComponents(url: URL, resolvingAgainstBaseURL: false) else {
            fatalError("Unable to create URL components from \(URL)")
        }
        
        components.queryItems = parameters.map {
            URLQueryItem(name: String($0), value: String($1))
        }
        
        guard let finalURL = components.url else {
            fatalError("Unable to retrieve final URL")
        }
        
        var request = URLRequest(url: finalURL)
        request.httpMethod = method.rawValue
        
        return request
    }
}

// Our API represented as an enum.
enum GisterAPI {
    case posts
    case albums
    case todos
    case users
}

// Conforms to Resource.
extension GisterAPI: Resource {
    
    // Sets the parameters
    var parameters: [String : String] {
        return ["":""]
    }
    
    // Sets the path
    var path: String {
        switch self {
        case .posts:
            return "posts/1"
        case .albums:
            return "albums/1"
        case .todos:
            return "todos/1"
        case .users:
            return "users/1"
        }
    }
}

// Contains networking code
class NetworkService {
    
    private let baseURL = URL(string: "https://jsonplaceholder.typicode.com/")!
    private let session: URLSession
    
    init(configuration: URLSessionConfiguration = URLSessionConfiguration.default) {
        self.session = URLSession(configuration: configuration)
    }
    
    // Returns a Result type of Data via URLSession
    func fetch(resource: GisterAPI, mergeWith dictionary: JSONDictionary) -> Promise<JSONDictionary> {
        return Promise { resolve, reject in
        let request = resource.requestWithBaseURL(baseURL: self.baseURL)
        let task = self.session.dataTask(with: request) { data, response, error in
            
            if let error = error {
                reject(error)
            } else {
                
                guard let HTTPResponse = response as? HTTPURLResponse else {
                    fatalError("Couldn't get HTTP response")
                }
                
                if 200 ..< 300 ~= HTTPResponse.statusCode {
                    let json = try! JSONSerialization.jsonObject(with: data!, options: []) as! JSONDictionary
                    print(json)
              
                    let dict = dictionary.merged(with: json)
                    print("Dictionary now contains: \(dict)")
                    resolve(dict)
                }
                    
                else {
                    reject(NetworkServiceError.decodeJSONError)
                }
            }
            
        }
        task.resume()
        }
    }
    
    func fetchOne(dictionary: JSONDictionary) -> Promise<JSONDictionary> {
        return fetch(resource: .users, mergeWith: dictionary)
    }
    
    func fetchTwo(dictionary: JSONDictionary) -> Promise<JSONDictionary> {
        return fetch(resource: .albums, mergeWith: dictionary)
    }
    
    func fetchThree(dictionary: JSONDictionary) -> Promise<JSONDictionary> {
        return fetch(resource: .todos, mergeWith: dictionary)
    }
    
    func fetchFour(dictionary: JSONDictionary) -> Promise<JSONDictionary> {
        return fetch(resource: .posts, mergeWith: dictionary)
    }
}
    
