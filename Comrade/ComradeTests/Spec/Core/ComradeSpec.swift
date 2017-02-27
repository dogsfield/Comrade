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
            it("Should be initialized with set of DataCollectors and DataStorages")
            {
                let storages: Array<DataStorage> = [TestDataStorage()]
                let collectors: Array<DataCollector> = [TestDataCollector()]
                _ = Comrade(collectors: collectors, storages: storages)
            }
        }
    }
}
