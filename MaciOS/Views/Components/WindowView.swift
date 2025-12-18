//
//  WindowView.swift
//  MaciOS
//
//  Generic wrapper for simulated application windows
//

import SwiftUI

struct WindowView: View {
    @EnvironmentObject var windowServer: WindowServer
    let window: AppWindow
    
    var body: some View {
        if !window.isMinimized {
            VStack(spacing: 0) {
                // Title bar with traffic lights
                TitleBar(window: window, onClose: {
                    windowServer.closeWindow(id: window.id)
                }, onMinimize: {
                    windowServer.toggleMinimize(id: window.id)
                }, onMaximize: {
                    // Maximize functionality (placeholder for now)
                })
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            let newPosition = CGPoint(
                                x: window.position.x + value.translation.width,
                                y: window.position.y + value.translation.height
                            )
                            windowServer.updatePosition(id: window.id, position: newPosition)
                        }
                )
                
                // Window content
                WindowContent(appType: window.appType)
            }
            .frame(width: window.size.width, height: window.size.height)
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .shadow(color: .black.opacity(0.3), radius: 20, x: 0, y: 10)
            .position(x: window.position.x + window.size.width / 2, y: window.position.y + window.size.height / 2)
            .zIndex(window.zIndex)
            .onTapGesture {
                windowServer.bringToFront(id: window.id)
            }
        }
    }
}

struct TitleBar: View {
    let window: AppWindow
    let onClose: () -> Void
    let onMinimize: () -> Void
    let onMaximize: () -> Void
    
    var body: some View {
        HStack {
            // Traffic light buttons
            HStack(spacing: 8) {
                TrafficLightButton(color: .red, action: onClose)
                TrafficLightButton(color: .yellow, action: onMinimize)
                TrafficLightButton(color: .green, action: onMaximize)
            }
            .padding(.leading, 12)
            
            Spacer()
            
            // Window title
            Text(window.title)
                .font(.system(size: 13, weight: .medium))
                .foregroundColor(.primary)
            
            Spacer()
            
            // Spacer to balance the title
            Color.clear
                .frame(width: 76) // Same width as traffic lights section
        }
        .frame(height: 40)
        .background(.ultraThinMaterial)
    }
}

struct TrafficLightButton: View {
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Circle()
                .fill(color)
                .frame(width: 12, height: 12)
                .overlay(
                    Circle()
                        .stroke(color.opacity(0.5), lineWidth: 0.5)
                )
        }
        .buttonStyle(.plain)
    }
}

struct WindowContent: View {
    let appType: String
    
    var body: some View {
        ZStack {
            // Background with subtle gradient
            LinearGradient(
                colors: [.white.opacity(0.9), .gray.opacity(0.1)],
                startPoint: .top,
                endPoint: .bottom
            )
            
            VStack {
                Spacer()
                
                // App-specific content
                switch appType {
                case "Finder":
                    FinderContent()
                case "Safari":
                    SafariContent()
                case "Settings":
                    SettingsContent()
                default:
                    DefaultContent(appType: appType)
                }
                
                Spacer()
            }
        }
    }
}

struct FinderContent: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "folder.fill")
                .font(.system(size: 64))
                .foregroundStyle(.blue)
            Text("Finder")
                .font(.title2)
                .fontWeight(.semibold)
        }
    }
}

struct SafariContent: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "safari.fill")
                .font(.system(size: 64))
                .foregroundStyle(.blue)
            Text("Safari")
                .font(.title2)
                .fontWeight(.semibold)
        }
    }
}

struct SettingsContent: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "gear")
                .font(.system(size: 64))
                .foregroundStyle(.gray)
            Text("Settings")
                .font(.title2)
                .fontWeight(.semibold)
        }
    }
}

struct DefaultContent: View {
    let appType: String
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "app.fill")
                .font(.system(size: 64))
                .foregroundStyle(.gray)
            Text(appType)
                .font(.title2)
                .fontWeight(.semibold)
            Text("Hello World")
                .font(.body)
                .foregroundColor(.secondary)
        }
    }
}

#Preview {
    WindowView(window: AppWindow(title: "Finder", appType: "Finder"))
        .environmentObject(WindowServer())
}
