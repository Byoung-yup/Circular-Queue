//
//  main.swift
//  Circular Queue
//
//  Created by 김병엽 on 2023/02/01.
//

import Foundation

struct RingBuffer<T>: CustomStringConvertible {
    fileprivate var array: [T?]
    fileprivate var front: Int = -1
    fileprivate var rear: Int = -1
    
    init(count: Int) {
        array = Array(repeating: nil, count: count)
    }
    
    var isEmpty: Bool {
        return front == -1 && rear == -1
    }
    
    var isFull: Bool {
        return ((rear + 1) % array.count) == front
    }
    
    var description: String {
        if isEmpty { return "Queue is empty..." }
        return "---- Queue Start ----\n"
        + array.map({ String(describing: "\($0)") }).joined(separator: " → ")
        + "\n---- Queue End ----\n"
    }
    
    var peek: T? {
        if isEmpty { return nil }
        return array[front]
    }
}

extension RingBuffer {
    
    mutating func enqueue(_ element: T) -> Bool {
        
        if front == -1 && rear == -1 {
            front = 0
            rear = 0
            array[front] = element
            return true
        }
        
        if isFull {
            print("Queue is Full...")
            return false
        }
        
        rear = (rear + 1) % array.count
        array[rear] = element
        return true
    }
    
    mutating func dequeue() -> T? {
        
        if isEmpty {
            print("Queue is Empty...")
            return nil
        }
        
        if front == rear {
            defer {
                array[front] = nil
                front = -1
                rear = -1
            }
            return array[front]
        }
        
        defer {
            array[front] = nil
            front = (front + 1) % array.count
        }
        return array[front]
    }
}
