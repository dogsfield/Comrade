//
//  DataCollector.swift
//  Comrade
//
//  Created by Michal Miedlarz on 27.02.2017.
//  Copyright © 2017 DogsField. All rights reserved.
//

import Foundation

public protocol DataCollectorDelegate: class
{
    func dataCollector(sender: DataCollector, handleChunk chunk: DataChunk?, error: Error?)
}

public protocol DataCollector
{
    weak var delegate: DataCollectorDelegate? { get set }
    func start()
    func stop()
    func isRunning() -> Bool
}
