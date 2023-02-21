//
//  TeamResponse.swift
//  SportsApp
//
//  Created by Dragon on 20/02/2023.
//

class TeamResult:Decodable{
    var team_name:String?
    var team_logo:String?
    var team_key:Int?
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
class coach:Decodable {
    var coach_name:String?
}
class TeamResultNew:Decodable{
    var team_key:Int?
    var players: [Player]
    var coaches:[coach]
}
class TeamResponseNew:Decodable{
    var success:Int?
    var result:[TeamResultNew]
}

