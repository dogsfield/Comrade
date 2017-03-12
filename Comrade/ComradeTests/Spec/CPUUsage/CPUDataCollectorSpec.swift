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
            
            it("Should create a data chunk")
            {
                
            }
        }
    }
}
