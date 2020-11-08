//
//  SkateparkParser.swift
//  Park Rat
//
//  Created by Tyler Huff on 11/3/20.
//  Copyright © 2020 Tyler Huff. All rights reserved.
//

import Foundation
import CoreXLSX



struct SkateparkParser {
    
    var skateparks = [Skatepark]()
    
    mutating func buildSkateparkArray(skateparkData: [String]){
        
        let lights : Bool
        if skateparkData[5] == "YES" {
            lights = true
        } else {
            lights = false
        }
        let safetyGear : Bool
        if skateparkData[6] == "YES" {
            safetyGear = true
        } else {
            safetyGear = false
        }
        let visited: Bool
        if skateparkData[9] == "NO" {
            visited = false
        } else {
            visited = true
        }
        
        let park = Skatepark(name: skateparkData[0], city: skateparkData[1], lights: lights, safetyGearRequired: safetyGear, type: skateparkData[7], visited: visited, address: skateparkData[3], latitude: Double(skateparkData[10])!, longitude: Double(skateparkData[11])!)
        skateparks.append(park)
        
    }
    
    mutating func excelParser() {
        
        if let filepath = Bundle.main.path(forResource: "CAskateparks", ofType: "xlsx") {
            
            guard let file = XLSXFile(filepath: filepath) else {
                fatalError("XLSX file at \(filepath) is corrupted or does not exist")
            }
            do {
                for wbk in try file.parseWorkbooks() {
                    for (name, path) in try file.parseWorksheetPathsAndNames(workbook: wbk) {
                        let worksheet = try file.parseWorksheet(at: path)
                        let sharedStrings = try file.parseSharedStrings()
                        for row in (worksheet.data?.rows) ?? [] {
                            let rowZeroStrings = worksheet.cells(atRows: [row.reference]).compactMap { $0.stringValue(sharedStrings)
                            }
                            buildSkateparkArray(skateparkData: rowZeroStrings)
                        }
                    }
                }
            } catch {
                print(error)
            }
        }
    }
    
    
    
}
