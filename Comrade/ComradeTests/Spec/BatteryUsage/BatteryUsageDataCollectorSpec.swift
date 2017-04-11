//
//  BatteryUsageDataCollectorSpec.swift
//  Comrade
//
//  Copyright © 2017 Michal Miedlarz
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

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
