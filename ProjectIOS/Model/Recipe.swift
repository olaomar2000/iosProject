//
//  Recipe.swift
//  ProjectIOS
//
//  Created by Hala Nasser on 5/20/21.
//

import Foundation
import FirebaseFirestore


struct Recipe:Identifiable , Codable {

    var id :String
    var name :String
    var image : String
    var ingredients :String
    var steps : String
    var cetgoryName :String
    var userId :Int
    
}
