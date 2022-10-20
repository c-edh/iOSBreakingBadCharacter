//
//  ImageLoader.swift
//  BreakingBadCharacters
//
//  Created by Corey Edh on 10/19/22.
//

import Foundation
import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

class ImageLoader: ObservableObject {
    let urlString: String?
    
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    
    init(urlString: String?) {
        self.urlString = urlString
    }
    
    func fetchCharacterImage() {

        isLoading = true
        
        guard let urlString = urlString else{
            return
        }
        
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage{
            print("retrieving cache image")
            DispatchQueue.main.async {
                self.image = imageFromCache
                self.isLoading = false
                
            }
            return
        }
        
        
        
        performRequest(with: urlString) {[weak self] data, error in
            
            guard let data = data, let image = UIImage(data: data) else{
              
                DispatchQueue.main.async {
                    self?.isLoading = false
                    self?.image = UIImage(systemName: "person.crop.square")
                }
                
                
                
                return
            }
            
            DispatchQueue.main.async {
                self?.image = image
            }
            imageCache.setObject(image, forKey: urlString as AnyObject)
        }
        
    }
    
    
    private func performRequest(with urlString: String, completion: @escaping (Data?, Error?) -> ()){
        
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response,  error in
                if error != nil{
                    completion(nil,error)
                }
                
                if let safeData = data{
                    completion(safeData, nil)
                }
            }
            task.resume()
            
        }
    }
    
    
}
