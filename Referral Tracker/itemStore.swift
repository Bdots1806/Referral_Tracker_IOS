//
//  itemStore.swift
//  Referral Tracker
//
//  Created by Manan Patel on 2022-12-11.
//

import Foundation

enum itemResult {
    case success([Shop])
    case failure(Error)
}

enum itemError : Error {
    case itemCreationError
}

//enum JSONError: Error {
//    case invalidJSONData
//}

class itemStore {
    var result : itemResult!
    
    let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()

    func getAllitems(completion: @escaping(itemResult)->Void) {
        let components = URLComponents(string: "http://localhost:3000/root")
        let url = components!.url
        let request = URLRequest(url: url!)
        let task = session.dataTask(with: request) {
            (data, response, error)->Void in
            if let jsonData = data {
                self.result = self.itemsCall(fromJSON: jsonData)
            } else if let requestError = error {
                print("Error fetching interesting items: \(requestError)")
            } else {
                print("Unexpected error with the request")
            }
            OperationQueue.main.addOperation {
                completion(self.result)
            }
        }
        task.resume()

    }
    
    func itemsCall(fromJSON data: Data)->itemResult {
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
            guard
                let jsonDictionary = jsonObject as? [AnyHashable:Any],
                let itemsArray = jsonDictionary["pics"] as? [[String:Any]]
                else {
                    return .failure(JSONError.invalidJSONData)
            }
            var finalItems = [Shop]()
            for itemJSON in itemsArray {
                if let item = item(fromJSON: itemJSON) {
                    finalItems.append(item)
                }
            }
            if finalItems.isEmpty && !itemsArray.isEmpty {
                return .failure(JSONError.invalidJSONData)
            }
            return .success(finalItems)
        } catch let error {
            return .failure(error)
        }
    }
    
    func item(fromJSON json: [String:Any])->Shop? {
        guard
            let id = json["id"] as! Int?,
            let title = json["title"] as! String?,
            let price = json["price"] as! String?
            else {
                return nil
        }
        return Shop(id: id, itemName: title, itemPrice: price)
    }
}
