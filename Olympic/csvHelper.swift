//
//  csvHelper.swift
//  Olympic
//
//  Created by Obrien Alaribe on 26/10/2016.
//  Copyright © 2016 Pam. All rights reserved.
//

import Foundation

struct Olympiad: CustomStringConvertible {
    var year: String
    var sport: String
    var country : String
    
    var description: String {
        return "Olympiad: (\(year), \(sport), \(country))"
    }
}


extension String {
    func csvRows() -> [[String]] {
        var rows : [[String]] = []
        
        let newlineCharacterSet = CharacterSet.newlines
        let importantCharactersSet = CharacterSet(charactersIn: ",\"").union(newlineCharacterSet)
        
        let scanner = Scanner(string: self)
        scanner.charactersToBeSkipped = nil
        
        while !scanner.isAtEnd {
            var insideQuotes = false
            var finishedRow = false
            var columns : [String] = []
            var currentColumn = ""
            while !finishedRow {
                var tempString : NSString? = nil
                if scanner.scanUpToCharacters(from: importantCharactersSet, into: &tempString) {
                    currentColumn.append(tempString! as String)
                }
                
                if scanner.isAtEnd {
                    if currentColumn != "" {
                        columns.append(currentColumn)
                    }
                    finishedRow = true
                } else if scanner.scanCharacters(from: newlineCharacterSet, into: &tempString) {
                    if insideQuotes {
                        // Add line break to column text
                        currentColumn.append(tempString! as String)
                    } else {
                        // End of row
                        if currentColumn != "" {
                            columns.append(currentColumn)
                        }
                        finishedRow = true
                    }
                } else if scanner.scanString("\"", into: nil) {
                    if insideQuotes && scanner.scanString("\"", into: nil) {
                        // Replace double quotes with a single quote in the column string.
                        currentColumn.append("\"")
                    } else {
                        // Start or end of a quoted string.
                        insideQuotes = !insideQuotes
                    }
                } else if scanner.scanString(",", into: nil) {
                    if insideQuotes {
                        currentColumn.append(",")
                    } else {
                        // This is a column separating comma
                        columns.append(currentColumn)
                        currentColumn = ""
                        scanner.scanCharacters(from: CharacterSet.whitespaces, into: nil)
                    }
                }
            }
            if columns.count > 0 {
                rows.append(columns)
            }
        }
        return rows
    }
}
