//
//  PathState.swift
//  PathOfLowerCost
//
//  Created by Mr.Ved on 5/11/17.
//  Copyright © 2017 Vishnu. All rights reserved.
//

import Foundation

class PathState {
    static let MAX_COST = 50
    var rowsTraversed = [Int]()
    var totalCost = 0
    var expectedLength = 0
    
    init() {
        
    }
    init(expectedLength: Int) {
        self.expectedLength = expectedLength
    }
    
    init(anotherPathState: PathState) {
        self.totalCost = anotherPathState.totalCost
        self.expectedLength = anotherPathState.expectedLength
        for i in anotherPathState.rowsTraversed {
            let rowTraversed = i
            self.rowsTraversed.append(rowTraversed)
        }
    }
    
    func getRowsTraversed() -> [Int] {
        return self.rowsTraversed
    }
    func getTotalCost() -> Int {
        return self.totalCost
    }
    func getPathLength() -> Int {
        return self.rowsTraversed.count;
    }
    
    func addRowWithCost(row: Int, cost:Int) {
        self.rowsTraversed.append(row);
        self.totalCost += cost;
    }
    
    func isComplete() -> Bool {
        return self.rowsTraversed.count == self.expectedLength;
    }
    
    func isSuccessful() -> Bool {
        return self.isComplete() && !self.isOverCost();
    }
    
    func isOverCost() -> Bool{
        return self.totalCost > PathState.MAX_COST;
    }
}
