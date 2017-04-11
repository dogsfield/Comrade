//
//  TestDataCollectorDelegate.swift
//  Comrade
//
//  Created by Michal Miedlarz on 12.03.2017.
//  Copyright © 2017 DogsField. All rights reserved.
//

import Foundation
import Comrade

class TestDataCollectorDelegate: DataCollectorDelegate
{
    var lastChunk: DataChunk?
    var lastError: Error?
    
    func dataCollector(sender: DataCollector, handleChunk chunk: DataChunk?, error: Error?)
    {
        lastChunk = chunk
        lastError = error
    }
}
