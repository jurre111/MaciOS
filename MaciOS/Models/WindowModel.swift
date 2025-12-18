//
//  WindowModel.swift
//  MaciOS
//
//  Models for the simulated windowing system
//

import SwiftUI

/// Represents a simulated application window
struct AppWindow: Identifiable {
    let id: UUID
    var title: String
    var appType: String
    var position: CGPoint
    var size: CGSize
    var zIndex: Double
    var isMinimized: Bool
    
    init(id: UUID = UUID(), title: String, appType: String, position: CGPoint = CGPoint(x: 50, y: 100), size: CGSize = CGSize(width: 300, height: 400), zIndex: Double = 0, isMinimized: Bool = false) {
        self.id = id
        self.title = title
        self.appType = appType
        self.position = position
        self.size = size
        self.zIndex = zIndex
        self.isMinimized = isMinimized
    }
}

/// Centralized window management system
class WindowServer: ObservableObject {
    @Published var windows: [AppWindow] = []
    
    private var nextZIndex: Double = 1.0
    
    /// Opens a new window for the specified app
    func openWindow(title: String, appType: String) {
        let newWindow = AppWindow(
            title: title,
            appType: appType,
            position: CGPoint(x: 50 + CGFloat(windows.count * 20), y: 100 + CGFloat(windows.count * 20)),
            size: CGSize(width: 300, height: 400),
            zIndex: nextZIndex,
            isMinimized: false
        )
        windows.append(newWindow)
        nextZIndex += 1
    }
    
    /// Closes the window with the specified ID
    func closeWindow(id: UUID) {
        windows.removeAll { $0.id == id }
    }
    
    /// Brings the specified window to the front
    func bringToFront(id: UUID) {
        if let index = windows.firstIndex(where: { $0.id == id }) {
            windows[index].zIndex = nextZIndex
            nextZIndex += 1
        }
    }
    
    /// Updates the position of a window
    func updatePosition(id: UUID, position: CGPoint) {
        if let index = windows.firstIndex(where: { $0.id == id }) {
            windows[index].position = position
        }
    }
    
    /// Toggles the minimize state of a window
    func toggleMinimize(id: UUID) {
        if let index = windows.firstIndex(where: { $0.id == id }) {
            windows[index].isMinimized.toggle()
        }
    }
}
