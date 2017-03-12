//
//  ComradeSpec.swift
//  Comrade
//
//  Created by Michal Miedlarz on 27.02.2017.
//  Copyright © 2017 DogsField. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import Comrade

class ComradeSpec: QuickSpec
{
    override func spec()
    {
        describe("Comrade library")
        {
            let storages: Array<DataStorage> = [TestDataStorage()]
            let collectors: Array<DataCollector> = [TestDataCollector()]
            
            it("Should be initialized with set of DataCollectors and DataStorages")
            {
                _ = Comrade(collectors: collectors, storages: storages)
            }
            
            it("Should be started")
            {
                let comrade = Comrade(collectors: collectors, storages: storages)
                comrade.start()
                expect(comrade.isRunning).to(beTrue())
            }
            
            it("Should be stopped after start")
            {
                let comrade = Comrade(collectors: collectors, storages: storages)
                comrade.start()
                expect(comrade.isRunning).to(beTrue())
                comrade.stop()
                expect(comrade.isRunning).to(beFalse())
            }
            
            it("Should not run when it was not started")
            {
                let comrade = Comrade(collectors: collectors, storages: storages)
                expect(comrade.isRunning).to(beFalse())
            }
        }
    }
}
