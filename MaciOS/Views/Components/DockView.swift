//
//  DockView.swift
//  MaciOS
//
//  Bottom dock with app icons
//

import SwiftUI

struct DockView: View {
    @EnvironmentObject var windowServer: WindowServer
    
    private let apps: [(icon: String, name: String, appType: String)] = [
        ("folder.fill", "Finder", "Finder"),
        ("safari.fill", "Safari", "Safari"),
        ("envelope.fill", "Mail", "Mail"),
        ("message.fill", "Messages", "Messages"),
        ("calendar", "Calendar", "Calendar"),
        ("photo.fill", "Photos", "Photos"),
        ("music.note", "Music", "Music"),
        ("appletv.fill", "TV", "TV"),
        ("gear", "Settings", "Settings")
    ]
    
    var body: some View {
        HStack(spacing: 8) {
            ForEach(apps, id: \.name) { app in
                DockIcon(icon: app.icon, name: app.name)
                    .onTapGesture {
                        windowServer.openWindow(title: app.name, appType: app.appType)
                    }
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
    }
}

struct DockIcon: View {
    let icon: String
    let name: String
    
    var body: some View {
        VStack(spacing: 4) {
            ZStack {
                // Background with gradient
                RoundedRectangle(cornerRadius: 12)
                    .fill(
                        LinearGradient(
                            colors: [.blue.opacity(0.8), .purple.opacity(0.8)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 50, height: 50)
                    .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 2)
                
                // Icon
                Image(systemName: icon)
                    .font(.system(size: 24))
                    .foregroundColor(.white)
            }
        }
        .frame(width: 50, height: 50)
    }
}

#Preview {
    DockView()
        .environmentObject(WindowServer())
}
