//
//  TakeNoteTests.swift
//  TakeNoteTests
//
//  Created by MEP LAB 01 on 23/06/22.
//

import XCTest
@testable import TakeNote

class TakeNoteTests: XCTestCase {

    var storyBoard: UIStoryboard!
    var notesList: NotesListViewController!
    
    override func setUpWithError() throws {
        storyBoard = UIStoryboard(name: "Main", bundle: nil)
        notesList = storyBoard.instantiateViewController(withIdentifier: "NotesListViewController") as? NotesListViewController
    }

    override func tearDownWithError() throws {
        storyBoard = nil
        notesList = nil
    }

    func testNotesListViewController_WhenViewIsLoaded_TheOutletsAreNotNill() throws {
        
        //Act
        notesList.loadViewIfNeeded()
        
        //Assert
        let tableView = try XCTUnwrap(notesList.notesTable, "NoteTable Found nil")
        XCTAssertFalse(tableView.isHidden, "Notestable is visible")
    }
    
    func testNotesListViewController_AssigningDataSource_NumberOfRowsShoulMatchTheData() {
        //Assign
        notesList.notes = []
        
        //Act
        notesList.loadViewIfNeeded()
        
        // Assert
        XCTAssertEqual(notesList.tableView(notesList.notesTable, numberOfRowsInSection: 0), notesList.notes.count, "Number of rows does not match the exact number")
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
