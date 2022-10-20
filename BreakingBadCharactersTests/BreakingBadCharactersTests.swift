//
//  BreakingBadCharactersTests.swift
//  BreakingBadCharactersTests
//
//  Created by Corey Edh on 10/20/22.
//

import XCTest
@testable import BreakingBadCharacters

final class BreakingBadCharactersTests: XCTestCase {
    
    private var breakingBadManager: BreakingBadManager!
    
    override func setUpWithError() throws{
        breakingBadManager = BreakingBadManager()
    }
    
    
    func test_getBreakingBadCharacters() async{
        
        let expectation = self.expectation(description: "getting characters data")
        breakingBadManager.getBreakingBadCharacters { characters in
            
            if let character = characters{
                expectation.fulfill()
            }else{
                XCTFail()
            }
            
            
        }
         await waitForExpectations(timeout: 10,handler: nil)
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
