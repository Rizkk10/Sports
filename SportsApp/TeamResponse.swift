//
//  TeamResponse.swift
//  SportsApp
//
//  Created by Dragon on 20/02/2023.
//

import Foundation
class TeamResult:Decodable{
    var team_name:String?
    var players: [Player]
    var coaches:[coach]
}
class coach:Decodable {
    var coach_name:String?
}
class TeamResponse:Decodable{
    var success:Int?
    var result:[TeamResult]
}
class Player : Decodable{
    var player_name: String?
    var player_number: String?
    var player_image: String?
}
