//
//  RouteMessage.swift
//  SortingHat
//
//  Created by 少 on 2019/3/5.
//

import Foundation

/// Message between modules, can be any type or nil.
public typealias RouteMessageType = Any

/// Handler is a closure to handle the message.
public typealias RouteMessageHandler = (RouteMessageType?) -> Void

/// Send message to another.
public protocol RouteMessageSenderType {
    var messageHandler: RouteMessageHandler? { get set }
}
