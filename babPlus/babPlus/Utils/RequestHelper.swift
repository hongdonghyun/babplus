//
//  RequestHelper.swift
//  babPlus
//
//  Created by Hongdonghyun on 2020/02/05.
//  Copyright © 2020 YoujinMac. All rights reserved.
//

import Foundation

// MARK: - Request Struct
struct RequestHelper {
    private func request(urlPath path:String, method: String) -> URLRequest? {
        guard let url = URL(string: Constants.base_url + path) else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }

    func reqTask(path: String = "menu", method: String = "GET", completion: @escaping (BabMenu) -> ()) {
        let task = URLSession.shared.dataTask(with: RequestHelper().request(urlPath: path, method: method)!) {
            data, response, error in
            if let res = response as? HTTPURLResponse {
                if (200...300).contains(res.statusCode) {
                    if let data = data, let body = try? JSONDecoder().decode(BabMenu.self, from: data) {
                        completion(body)
                    } else {
                        print("parse Error")
                    }
                }
            } else {
                print("Error")
            }
            
        }
        task.resume()
    }
}
