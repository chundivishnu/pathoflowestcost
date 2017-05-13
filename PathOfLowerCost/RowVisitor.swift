//
//  RowVisitor.swift
//  PathOfLowerCost
//
//  Created by Mr.Ved on 5/11/17.
//  Copyright © 2017 Vishnu. All rights reserved.
//

import Foundation

class RowVisitor {
    var row: Int?
    var grid: Grid?
    var pathCollector: PathStateCollector?
    
    init(startRow: Int, grid: Grid?, collector: PathStateCollector?) {
        if grid == nil {
            print("A visitor requires a grid")
        } else if collector == nil {
            print("A visitor requires a collector")
        } else if startRow > 0 && startRow <= (grid?.getRowCount())! {
            self.row = startRow
            self.grid = grid
            self.pathCollector = collector
        } else {
            print("Cannot visit a row outside of grid boundaries")
        }
    }
    
    func getBestPathForRow () -> PathState {
        let initialPath = PathState(expectedLength: (self.grid?.getColumnCount())!)
        self.visitPathsForRow(row: self.row!, path: initialPath)
        return (self.pathCollector?.getBestPath())!
    }
    
    func visitPathsForRow(row: Int, path: PathState) {
        if self.canVisitRowOnPath(row: row, path: path)  {
            self.visitRowOnPath(row: row, path: path)
        }
        
        let adjacentRows = self.grid?.getRowsAdjacentTo(rowNumber: row)
        var currentPathAdded = false
        for i in adjacentRows! {
            let adjacentRow = i
            if self.canVisitRowOnPath(row: adjacentRow, path: path) {
                let pathCopy = PathState(anotherPathState: path);
                self.visitPathsForRow(row: adjacentRow, path: pathCopy);
            } else if(!currentPathAdded) {
                self.pathCollector?.addPath(newPath: path);
                currentPathAdded = true;
            }
        }
    }
    
    func canVisitRowOnPath(row: Int, path: PathState) -> Bool {
        return !path.isComplete() && !self.nextVisitOnPathWouldExceedMaximumCost(row: row, path: path);
    }
    
    func visitRowOnPath(row: Int, path: PathState) {
        let columnToVisit = path.getPathLength() + 1;
        path.addRowWithCost(row: row, cost:self.grid!.getValueForRowAndColumn(row: row, column: columnToVisit));
    }
    
    func nextVisitOnPathWouldExceedMaximumCost(row: Int, path: PathState) -> Bool {
        let nextColumn = path.getPathLength() + 1;
        return path.getTotalCost() + (self.grid?.getValueForRowAndColumn(row: row, column: nextColumn))! > PathState.MAX_COST;
    }
    
}
