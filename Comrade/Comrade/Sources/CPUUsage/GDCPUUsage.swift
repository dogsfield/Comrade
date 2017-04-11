//
//  GDCPUUsage.swift
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

//  Based on awesome solution by Daniil Gavrilov:
//  https://github.com/dani-gavrilov
//  https://github.com/dani-gavrilov/GDPerformanceView-Swift
class GDCPUUsage
{
    class func collectCPUUsage() -> Float
    {
        let basicInfoCount = MemoryLayout<mach_task_basic_info_data_t>.size / MemoryLayout<natural_t>.size
        
        var kern: kern_return_t
        
        var threadList = UnsafeMutablePointer<thread_act_t>.allocate(capacity: 1)
        var threadCount = mach_msg_type_number_t(basicInfoCount)
        
        var threadInfo = thread_basic_info.init()
        var threadInfoCount: mach_msg_type_number_t
        
        var threadBasicInfo: thread_basic_info
        var threadStatistic: UInt32 = 0
        
        kern = withUnsafeMutablePointer(to: &threadList)
        {
            #if swift(>=3.1)
                return $0.withMemoryRebound(to: thread_act_array_t?.self, capacity: 1)
                {
                    task_threads(mach_task_self_, $0, &threadCount)
                }
            #else
                return $0.withMemoryRebound(to: (thread_act_array_t?.self)!, capacity: 1)
                {
                    task_threads(mach_task_self_, $0, &threadCount)
                }
            #endif
        }
        
        if kern != KERN_SUCCESS
        {
            return -1
        }
        
        if threadCount > 0
        {
            threadStatistic += threadCount
        }
        
        var totalUsageOfCPU: Float = 0.0
        
        for i in 0..<threadCount
        {
            threadInfoCount = mach_msg_type_number_t(THREAD_INFO_MAX)
            
            kern = withUnsafeMutablePointer(to: &threadInfo)
            {
                $0.withMemoryRebound(to: integer_t.self, capacity: 1)
                {
                    thread_info(threadList[Int(i)], thread_flavor_t(THREAD_BASIC_INFO), $0, &threadInfoCount)
                }
            }
            if kern != KERN_SUCCESS
            {
                return -1
            }
            
            threadBasicInfo = threadInfo as thread_basic_info
            
            if threadBasicInfo.flags & TH_FLAGS_IDLE == 0
            {
                totalUsageOfCPU = totalUsageOfCPU + Float(threadBasicInfo.cpu_usage) / Float(TH_USAGE_SCALE) * 100.0
            }
        }
        
        return totalUsageOfCPU
    }
}
