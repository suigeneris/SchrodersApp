//
//  NetworkService.swift
//  SportingLifeFastResults
//
//  Created by John Galloway on 30/10/2018.
//  Copyright © 2018 Sky Betting & Gaming. All rights reserved.
//

import Foundation

protocol NetworkService: class {

    func getJSONFromURL(_ url: URL, completion: @escaping (_ data: Data?, _ error: Error?) -> Void)

}

extension NetworkService {

    var session: URLSession {
        let urlconfig = URLSessionConfiguration.default
        urlconfig.timeoutIntervalForRequest = Configuration.requestTimeout
        return URLSession(configuration: urlconfig)
    }

}

class NetworkServiceImpl: NetworkService {

    public func getJSONFromURL(_ url: URL, completion: @escaping (_ data: Data?, _ error: Error?) -> Void) {
        let task = session.dataTask(with: url) { (data, _, error) in
            guard error == nil else {
                return completion(nil, error)
            }
            completion(data, nil)
        }
        task.resume()
    }
}
