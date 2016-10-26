//
//  main.swift
//  Olympic
//
//  Created by Obrien Alaribe on 26/10/2016.
//  Copyright © 2016 Pam. All rights reserved.
//

import Foundation




let file = "/Users/oalaribe/Documents/Swift/Olympic/golds.csv" //this is the file. we will write to and read from it

let location = NSString(string:file)
let fileContent = try? String(contentsOfFile: location as String, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))

let dataArr = fileContent!.csvRows()

var records = [Olympiad]()
var goldTotalsByYear = Dictionary<String, Dictionary<String, Int>>()


var previousYear = "1000"

for data in dataArr {
    if dataArr.first! == data{
        continue
    }else{
        
        let record = Olympiad(year: data[0], sport: data[1], country: data[2])
        records.append(record)
    }
}

    
    var countryDictionaryCount = Dictionary<String, Int>()

for record in records {
    if previousYear != record.year {
        print(" ------------------------ create new dictionay for year")
        //create new country list for this year
        countryDictionaryCount = Dictionary<String, Int>()
        
        countryDictionaryCount[record.country] = 1
        
        goldTotalsByYear[record.year] = countryDictionaryCount


    }else if let total = countryDictionaryCount[record.country] {
            countryDictionaryCount[record.country] = total + 1
        goldTotalsByYear[record.year] = countryDictionaryCount

        }else{
            countryDictionaryCount[record.country] = 1
            goldTotalsByYear[record.year] = countryDictionaryCount

        }


        previousYear = record.year

    }


print(" \(goldTotalsByYear)")


