//
//  PathStateComparator.swift
//  PathOfLowerCost
//
//  Created by Mr.Ved on 5/11/17.
//  Copyright © 2017 Vishnu. All rights reserved.
//

import Foundation

class PathStateComparator {
    let SORT_LEFT_FIRST = -1;
    let SORT_RIGHT_FIRST = 1;
    let SORT_EQUAL = 0;
    
    init() {
        
    }
    
    func compare(leftPath: PathState, rightPath: PathState) -> Int {
        let comparedLength = self.compareLengths(leftPath: leftPath, rightPath: rightPath);
        return comparedLength != 0 ? comparedLength : self.compareCosts(leftPath: leftPath, rightPath: rightPath);
    }
    
    func compareLengths(leftPath: PathState, rightPath: PathState) -> Int {
        let leftLength = self.getLengthFromPath(path: leftPath);
        let rightLength = self.getLengthFromPath(path: rightPath);
        return leftLength > rightLength ? SORT_LEFT_FIRST : (leftLength == rightLength ? SORT_EQUAL : SORT_RIGHT_FIRST);
    }
    
    func compareCosts(leftPath: PathState, rightPath: PathState) -> Int {
        let leftCost = self.getCostFromPath(path: leftPath);
        let rightCost = self.getCostFromPath(path: rightPath);
        return leftCost < rightCost ? SORT_LEFT_FIRST : (leftCost == rightCost ? SORT_EQUAL : SORT_RIGHT_FIRST);
    }
    
    func getLengthFromPath(path: PathState?) -> Int {
        return path != nil ? path!.getPathLength() : -2147483648;
    }
    
    func getCostFromPath(path: PathState?) -> Int {
        return path != nil ? path!.getTotalCost() : 2147483647;
    }
}
