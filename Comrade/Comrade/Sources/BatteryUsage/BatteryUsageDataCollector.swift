//
//  BatteryUsageDataCollector.swift
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

public class BatteryUsageDataCollector: NSObject, DataCollector
{

    public let timeInterval: TimeInterval
    public let device: UIDevice
    public weak var delegate: DataCollectorDelegate?
    private var timer: Timer?
    
    init(timeInterval: TimeInterval, device: UIDevice = UIDevice.current)
    {
        self.timeInterval = timeInterval
        self.device = device
    }
    
    //MARK: DataCollector protocol implementation
    public func isRunning() -> Bool
    {
        return timer != nil
    }
    
    public func stop()
    {
        clearTimer()
    }
    
    public func start()
    {
        clearTimer()
        timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(collectBatteryData), userInfo: nil, repeats: true)
    }
    
    //MARK: Utils
    func collectBatteryData()
    {
        let chunk = BatteryUsageDataChunk(level: device.batteryLevel, state: device.batteryState)
        delegate?.dataCollector(sender: self, handleChunk: chunk, error: nil)
    }
    
    private func clearTimer()
    {
        timer?.invalidate()
        timer = nil
    }
}
