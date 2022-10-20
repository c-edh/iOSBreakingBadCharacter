//
//  BreakingBadManager.swift
//  BreakingBadCharacters
//
//  Created by Corey Edh on 10/19/22.
//

import Foundation


class BreakingBadManager{
    

    
     func getBreakingBadCharacters(completion: @escaping ([CharacterModel]?) -> ()){
        
        let urlString = "https://breakingbadapi.com/api/characters"
        
        performRequest(with: urlString) { data, error in
            if error != nil{
                print(error?.localizedDescription)
            }
            
            guard let data = data else{
                return
            }
            guard let characters = self.parseCharacterData(with: data) else{
                return
            }
    
            completion(characters)

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
    
    
    private func parseCharacterData(with data: Data?) -> [CharacterModel]?{
        
        guard let data = data else{
            return nil
        }

        
        let decoder = JSONDecoder()
        
        do{
            let decodeData = try decoder.decode([CharacterModel].self, from: data)

            let characters = decodeData
            
            return characters
        }catch{
            print(error)
            return nil
        }
    }
    
    
    
    
    
    
    
}
