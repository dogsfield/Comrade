//
//  BatteryUsageDataCollectorSpec.swift
//  Comrade
//
//  Created by Michal Miedlarz on 12.03.2017.
//  Copyright © 2017 DogsField. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import Comrade

class BatteryUsageDataCollectorSpec: QuickSpec
{
    override func spec()
    {        
        describe("Battery Collector")
        {
            it("Should be initialized with time interval")
            {
                let interval: TimeInterval = 5
                _ = BatteryUsageDataCollector(timeInterval: interval)
            }
            
            it("Should have TimeInterval equal to value set in init")
            {
                let interval: TimeInterval = 5
                let collector = BatteryUsageDataCollector(timeInterval: interval)
                expect(collector.timeInterval).to(equal(interval))
            }
            
            it("Should not run after init")
            {
                let collector = BatteryUsageDataCollector(timeInterval: 1)
                expect(collector.isRunning()).to(beFalse())
            }
            
            it("Should run after calling start() method")
            {
                let collector = BatteryUsageDataCollector(timeInterval: 1)
                expect(collector.isRunning()).to(beFalse())
                collector.start()
                expect(collector.isRunning()).to(beTrue())
            }
            
            it("Should stop after calling stop() method")
            {
                let collector = BatteryUsageDataCollector(timeInterval: 1)
                expect(collector.isRunning()).to(beFalse())
                collector.start()
                expect(collector.isRunning()).to(beTrue())
                collector.stop()
                expect(collector.isRunning()).to(beFalse())
            }
            
            it("Should collect and send some data")
            {
                let collector = BatteryUsageDataCollector(timeInterval: 1, device: UIDevice.current)
                let delegate = TestDataCollectorDelegate()
                collector.delegate = delegate
                expect(delegate.lastChunk).to(beNil())
                expect(delegate.lastError).to(beNil())
                collector.start()
                expect(delegate.lastChunk as? BatteryUsageDataChunk).toNotEventually(beNil(), timeout: 3, pollInterval: 1)
                expect(delegate.lastError).toEventually(beNil(), timeout: 3, pollInterval: 1)
            }
        }
    }
}
