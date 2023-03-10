//
//  PicStore.swift
//  Assignment_5
//
//  Created by Manan Patel on 11/26/22.
//

import UIKit

enum PicsResult {
    case success([Pic])
    case failure(Error)
}

enum ImageResult {
    case success(UIImage)
    case failure(Error)
}

enum PicError : Error {
    case picCreationError
}

enum JSONError: Error {
    case invalidJSONData
}

class PicStore {
    var result : PicsResult!
    
    let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    
    func getAllPics(completion: @escaping(PicsResult)->Void) {
        let components = URLComponents(string: "http://localhost:3000/root")
        let url = components!.url
        let request = URLRequest(url: url!)
        let task = session.dataTask(with: request) {
            (data, response, error)->Void in
            if let jsonData = data {
                self.result = self.picsCall(fromJSON: jsonData)
            } else if let requestError = error {
                print("Error fetching inserting pics: \(requestError)")
            } else {
                print("Unexpected error with the request")
            }
            OperationQueue.main.addOperation {
                completion(self.result)
            }
        }
        task.resume()
    }
    func picsCall(fromJSON data: Data)->PicsResult {
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
            guard
                let jsonDictionary = jsonObject as? [AnyHashable:Any],
                let picsArray = jsonDictionary["pics"] as? [[String:Any]]
            else {
                return .failure(JSONError.invalidJSONData)
            }
          //  print("Done till here")
            var finalPics = [Pic]()
            for picJSON in picsArray {
                if let pic = pic(fromJSON: picJSON) {
                    finalPics.append(pic)
              //      print("Done till here2")
                }
            }
            if finalPics.isEmpty && !picsArray.isEmpty {
                return .failure(JSONError.invalidJSONData)
            }
           // print("Done till here3")
            return .success(finalPics)
        } catch let error {
            return .failure(error)
        }
    }
    
    func pic(fromJSON json: [String:Any])->Pic? {
        guard
            let id = json["id"] as! Int?,
            let title = json["title"] as! String?,
            let remoteURL = json["url"] as! String?,
            let price = json["price"] as! String?
        else {
            return nil
        }
      //  print("Done till here4")
        return Pic(id: id, remoteURL: remoteURL, title: title, price: price)
    }
    
    func fetchImage(for pic: Pic, completion: @escaping                        (ImageResult)->Void) {
        let picURL = pic.remoteURL
      //  print("Entered fetching image")
        let request = URLRequest(url: URL(string: picURL)!)
        let task = session.dataTask(with: request) {
            (data, response, error)->Void in
            let result = self.processImageResult(data: data, error: error)
            OperationQueue.main.addOperation {
                completion(result)
            }
        }
        task.resume()
     //   print("Done fetching image")
    }
    
    private func processImageResult(data: Data?, error: Error?)->ImageResult {
        guard
            let imageData = data,
            let image = UIImage(data: imageData)
        else {
            if (data == nil) {
                return .failure(error!)
            } else {
                return .failure(PicError.picCreationError)
            }
        }
      //  print("Done processing image")
        return .success(image)
    }
}
