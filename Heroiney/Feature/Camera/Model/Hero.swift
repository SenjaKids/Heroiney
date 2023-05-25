//
//  Hero.swift
//  Heroiney
//
//  Created by Alfine on 25/05/23.
//

import Foundation

struct Hero: Codable, Identifiable {
    var id: String
    var name: String
    var date: String
    var story: String
    var photo: String
    
    static let allHero: [Hero] = Bundle.main.decode(file: "HeroDatas.JSON")
    static let sample: Hero = allHero[0]
//    init(id: String, name: String, date: String, story: String, photo: String) {
//        self.id = id
//        self.name = name
//        self.date = date
//        self.story = story
//        self.photo = photo
//    }
}

extension Bundle {
    func decode<T: Decodable>(file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }

        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }

        let decoder = JSONDecoder()

        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(file) from bundle.")
        }
        return loaded
        
    }
//    func decode(_ file: String) -> [String: Hero] {
//        guard let url = self.url(forResource: file, withExtension: ".JSON") else {
//            fatalError("Failed to locate \(file) in bundle.")
//        }
//
//        guard let data = try? Data(contentsOf: url) else {
//            fatalError("Failed to load \(file) from bundle.")
//        }
//
//        let decoder = JSONDecoder()
//
//        guard let loaded = try? decoder.decode([String: Hero].self, from: data) else {
//            fatalError("Failed to decode \(file) from bundle.")
//        }
//
//        return loaded
//    }
}
