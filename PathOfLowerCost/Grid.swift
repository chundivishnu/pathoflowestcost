//
//  Grid.swift
//  PathOfLowerCost
//
//  Created by Mr.Ved on 5/10/17.
//  Copyright © 2017 Vishnu. All rights reserved.
//

import Foundation

class Grid {
    var values: [[Int]]?
    
    init(values: [[Int]]) {
        if values.count >= 1 && values.count <= 10 {
            if values[0].count >= 1 && values[0].count <= 100 {
                self.values = values
            } else {
                print("Between five and one hundred columns of values are expected")
            }
        } else {
            print("Between one and ten rows of values are expected")
        }
    }
    
    func getValueForRowAndColumn(row: Int, column: Int) -> Int {
        let valueAtIndex = self.values![row-1][column-1]
        return valueAtIndex
    }
    
    func getRowCount() -> Int {
        return (self.values?.count)!
    }
    
    func getColumnCount() -> Int {
        return self.values![0].count
    }
    
    func getRowsAdjacentTo(rowNumber: Int) -> [Int] {
        var adjacentRows = [Int]()
        if self.isValidRowNumber(rowNumber: rowNumber) {
            adjacentRows.append(rowNumber)
            adjacentRows.append(self.getRowAbove(rowNumber: rowNumber))
            adjacentRows.append(self.getRowBelow(rowNumber: rowNumber))
        }
        return adjacentRows
    }
    
    func isValidRowNumber(rowNumber: Int) -> Bool {
        return rowNumber > 0 && rowNumber <= (self.values?.count)!
    }
    
    func getRowAbove(rowNumber: Int) -> Int {
        let potentialRowNumber = rowNumber-1
        return potentialRowNumber < 1 ? (self.values?.count)! : potentialRowNumber
    }
    
    func getRowBelow(rowNumber: Int) -> Int {
        let potentialNumber = rowNumber+1
        return potentialNumber > (self.values?.count)! ? 1 : potentialNumber
    }
}
