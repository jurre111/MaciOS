//
//  MenuBar.swift
//  MaciOS
//
//  Top menu bar with Apple logo, menus, and status items
//

import SwiftUI

struct MenuBar: View {
    @State private var currentTime = Date()
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        HStack(spacing: 0) {
            // Left side: Apple logo and menus
            HStack(spacing: 16) {
                // Apple logo
                Image(systemName: "apple.logo")
                    .font(.system(size: 18))
                    .foregroundColor(.primary)
                    .padding(.leading, 12)
                
                // Menu items
                MenuBarItem(title: "MaciOS")
                MenuBarItem(title: "File")
                MenuBarItem(title: "Edit")
                MenuBarItem(title: "View")
                MenuBarItem(title: "Go")
                MenuBarItem(title: "Window")
                MenuBarItem(title: "Help")
            }
            
            Spacer()
            
            // Right side: Status items
            HStack(spacing: 16) {
                // WiFi icon
                Image(systemName: "wifi")
                    .font(.system(size: 14))
                
                // Battery icon
                Image(systemName: "battery.100")
                    .font(.system(size: 14))
                
                // Time
                Text(formattedTime)
                    .font(.system(size: 13))
                    .monospacedDigit()
            }
            .foregroundColor(.primary)
            .padding(.trailing, 12)
        }
        .frame(height: 28)
        .background(.ultraThinMaterial)
        .onReceive(timer) { input in
            currentTime = input
        }
    }
    
    private var formattedTime: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E MMM d  h:mm a"
        return formatter.string(from: currentTime)
    }
}

struct MenuBarItem: View {
    let title: String
    
    var body: some View {
        Text(title)
            .font(.system(size: 13, weight: .medium))
            .foregroundColor(.primary)
    }
}

#Preview {
    MenuBar()
}
