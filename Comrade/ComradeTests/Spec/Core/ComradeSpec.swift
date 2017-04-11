//
//  ComradeSpec.swift
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
