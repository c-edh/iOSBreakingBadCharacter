//
//  File.swift
//  BreakingBadCharacters
//
//  Created by Corey Edh on 10/19/22.
//

import Foundation


class BreakingBadViewModel: ObservableObject{
    
    @Published var characterList: [CharacterModel] = []
    @Published var breakingBadSeasons: [String] = ["All Seasons", "1","2","3","4","5"]
    
    private var breakingBadCharacters : [CharacterModel] = []
    
    
    private var breakingBadManager = BreakingBadManager()
    
    func getCharacters(){
        
        //Will only get the characters if it hasnt been called yet
        if characterList.count == 0{
            
            breakingBadManager.getBreakingBadCharacters { characters in
                guard let characters = characters else{
                    return
                }
                self.breakingBadCharacters = characters
                
                DispatchQueue.main.async {
                    self.characterList = characters
                }
            }
            
        }
    }
    
    
    //Filters characters by search
    func searchCharacter(_ search: String){
            let characters = characterList
        DispatchQueue.main.async {
            
            if search.isEmpty {
                self.characterList = self.breakingBadCharacters
            } else {
                self.characterList = characters.filter { $0.name!.contains(search) }
            }
            
        }
    }
    
    //Filters characters by season
    func filterBySeason(_ season: String){
        let characters = characterList
        DispatchQueue.main.async {
            if season != "All Seasons"{
                if let season = Int(season){
                    self.characterList = characters.filter({$0.appearance!.contains(season)})
                    
                }
            }else{
                self.characterList = self.breakingBadCharacters
            }
            
        }
    }
    

    

    
    
    
    
}
