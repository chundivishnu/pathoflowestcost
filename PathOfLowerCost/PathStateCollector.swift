//
//  PathStateCollector.swift
//  PathOfLowerCost
//
//  Created by Mr.Ved on 5/11/17.
//  Copyright © 2017 Vishnu. All rights reserved.
//

import Foundation

class PathStateCollector {
    var bestPath = PathState()
    var comparator = PathStateComparator()
    
    func getBestPath() -> PathState {
        return self.bestPath
    }
    
    func addPath(newPath: PathState) {
        if (self.comparator.compare(leftPath: newPath, rightPath: self.bestPath) < 0) {
            self.bestPath = newPath
        }
    }
}
