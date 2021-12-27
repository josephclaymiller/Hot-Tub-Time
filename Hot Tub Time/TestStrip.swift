//
//  TestStrip.swift
//  Hot Tub Time
//
//  Created by Joseph Miller on 12/20/21.
//

import Foundation

struct TotalBromine: Codable {
    static let idealRange = 3...5
    var partsPerMillion: Int
    
    init(_ bromine: Int) {
        partsPerMillion = bromine
    }
    
    func isGood() -> Bool {
        return TotalBromine.idealRange.contains(partsPerMillion)
    }
}

struct Alkalinity: Codable {
    static let idealRange = 80...120
    var partsPerMillion: Int
    
    init(_ alkaline: Int) {
        partsPerMillion = alkaline
    }
    
    func isGood() -> Bool {
        return Alkalinity.idealRange.contains(partsPerMillion)
    }
}
// potential of hydrogen
struct HydrogenPotential: Codable {
    static let idealRange = 7.2...7.6
    var reading: Double
    
    init(_ ph: Double) {
        reading = ph
    }
    
    func isGood() -> Bool {
        return HydrogenPotential.idealRange.contains(reading)
    }
}

struct CalciumHardness: Codable {
    static let idealRange = 250...450
    var partsPerMillion: Int
    
    init(_ hardnress: Int) {
        partsPerMillion = hardnress
    }
    
    func isGood() -> Bool {
        return CalciumHardness.idealRange.contains(partsPerMillion)
    }
}

enum Strip {
    case bromine(TotalBromine, Alkalinity, HydrogenPotential, CalciumHardness)
    // TODO: Add case for clorine if needed
}

struct TestStrip: CustomStringConvertible, Codable  {
    let TBr: TotalBromine! // Total Bromine parts per million
    let ALk: Alkalinity! // Alkalinity
    let pH: HydrogenPotential!
    let CH: CalciumHardness! // Calcium Hardness parts per million
    let date: Date!
    var description: String {
        "[\(TBr.partsPerMillion), \(ALk.partsPerMillion), \(pH.reading), \(CH.partsPerMillion)]"
    }
    
    init(_ strip: Strip) {
        switch strip {
        case .bromine(let tbr, let alk, let ph, let ch):
            TBr = tbr
            ALk = alk
            pH = ph
            CH = ch
        }
        //self.date = Date.now // only available in iOS 15 or newer
        self.date = Date()
    }
    
//    init(from string: String) {
//        let newString = string.dropFirst().dropLast()
//        let readingArray = newString.split(separator: ",")
//        print(newString)
//        print(readingArray)
//        TBr = Int(readingArray[0])
//        ALk = Int(readingArray[1])
//        pH = Double(readingArray[2])
//        CH = Int(readingArray[3])
//    }
    
//    required init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        TBr = try values.decode(TotalBromine.self, forKey: .TBr)
//        ALk = try values.decode(Alkalinity.self, forKey: .ALk)
//        pH = try values.decode(HydrogenPotential.self, forKey: .pH)
//        CH = try values.decode(CalciumHardness.self, forKey: .CH)
//        date = try values.decode(Date.self, forKey: .date)
//    }
//
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(TBr, forKey: .TBr)
//        try container.encode(ALk, forKey: .ALk)
//        try container.encode(pH, forKey: .pH)
//        try container.encode(CH, forKey: .CH)
//        try container.encode(date, forKey: .date)
//    }
//
//    enum CodingKeys: String, CodingKey {
//        case TBr
//        case ALk
//        case pH
//        case CH
//        case date
//    }
    
    // If it is okay to go in the hot tub based on the test strip reading
    func isGood() -> Bool {
        return (TBr.isGood() && ALk.isGood() && pH.isGood() && CH.isGood())
    }
}

//protocol for strip elements?
