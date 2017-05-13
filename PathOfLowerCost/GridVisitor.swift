//
//  GridVisitor.swift
//  PathOfLowerCost
//
//  Created by Mr.Ved on 5/11/17.
//  Copyright © 2017 Vishnu. All rights reserved.
//

import Foundation

class GridVisitor {
    var grid: Grid?;
    var pathComparator: PathStateComparator?;
    
    init(grid: Grid?) {
        if grid == nil {
            print("A visitor requires a grid")
        } else {
            self.grid = grid
            self.pathComparator = PathStateComparator()
        }
    }
    
    func getBestPathForGrid() -> PathState {
        var allPaths = [PathState]()
        let valuesCount = (self.grid?.getRowCount())!
        for row in 1 ... valuesCount {
            let visitor: RowVisitor = RowVisitor(startRow: row, grid: self.grid!, collector: PathStateCollector())
            let path = visitor.getBestPathForRow()
            allPaths.append(path)
        }
        allPaths.sort(by: {
            (self.pathComparator?.compare(leftPath: $0, rightPath: $1))! < 0
        })
        return allPaths[0]
    }
}
