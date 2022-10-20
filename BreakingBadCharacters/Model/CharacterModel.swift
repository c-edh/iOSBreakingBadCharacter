//
//  BreakingBadCharacter.swift
//  BreakingBadCharacters
//
//  Created by Corey Edh on 10/19/22.
//

import Foundation


struct CharacterModel: Codable{
    
    
    let char_id: Int
    let name: String?
    let occupation: [String]?
    let img: String?
    let status: String?
    let nickname: String?
    let appearance: [Int]?

}
