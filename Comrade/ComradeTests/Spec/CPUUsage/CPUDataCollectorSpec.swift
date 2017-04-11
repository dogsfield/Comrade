//
//  CPUDataCollectorSpec.swift
//  Comrade
//
//  Created by Nomtek on 12.03.2017.
//  Copyright © 2017 DogsField. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import Comrade

class CPUDataCollectorSpec: QuickSpec
{
    override func spec()
    {
        describe("CPUDataCollector")
        {
            it("Should have proper time interval")
            {
                let dataCollector = CPUDataCollector(timeInterval: 3)
                expect(dataCollector.timeInterval).to(equal(3))
            }
            
            it("Should start data collection")
            {
                let dataCollector = CPUDataCollector(timeInterval: 3)
                dataCollector.start()
                expect(dataCollector.isRunning()).to(beTrue())
            }
            
            it("Should stop data collection")
            {
                let dataCollector = CPUDataCollector(timeInterval: 3)
                dataCollector.stop()
                expect(dataCollector.isRunning()).to(beFalse())
            }
            
            it("Should stop after calling stop() method")
            {
                let collector = CPUDataCollector(timeInterval: 3)
                expect(collector.isRunning()).to(beFalse())
                collector.start()
                expect(collector.isRunning()).to(beTrue())
                collector.stop()
                expect(collector.isRunning()).to(beFalse())
            }
            
            it("Should collect and send some data")
            {
                let collector = CPUDataCollector(timeInterval: 1)
                let delegate = TestDataCollectorDelegate()
                collector.delegate = delegate
                expect(delegate.lastChunk).to(beNil())
                expect(delegate.lastError).to(beNil())
                collector.start()
                expect(delegate.lastChunk as? CPUDataChunk).toNotEventually(beNil(), timeout: 3, pollInterval: 1)
                expect(delegate.lastError).toEventually(beNil(), timeout: 3, pollInterval: 1)
            }
        }
    }
}
