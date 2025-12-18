//
//  ContentView.swift
//  MaciOS
//
//  Main desktop container for the macOS simulator
//

import SwiftUI

struct ContentView: View {
    @StateObject private var windowServer = WindowServer()
    
    var body: some View {
        ZStack {
            // Wallpaper - Tahoe-inspired gradient
            LinearGradient(
                colors: [
                    Color(red: 0.2, green: 0.4, blue: 0.8),
                    Color(red: 0.4, green: 0.2, blue: 0.6),
                    Color(red: 0.6, green: 0.3, blue: 0.7)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            // Desktop Icons (placeholder for now)
            VStack {
                HStack {
                    VStack(spacing: 20) {
                        DesktopIcon(name: "Macintosh HD", icon: "internaldrive.fill")
                        DesktopIcon(name: "Documents", icon: "folder.fill")
                        DesktopIcon(name: "Downloads", icon: "arrow.down.circle.fill")
                    }
                    .padding(.top, 60)
                    .padding(.leading, 20)
                    
                    Spacer()
                }
                
                Spacer()
            }
            
            // Open Windows
            ForEach(windowServer.windows.sorted(by: { $0.zIndex < $1.zIndex })) { window in
                WindowView(window: window)
                    .environmentObject(windowServer)
            }
            
            // Dock
            VStack {
                Spacer()
                DockView()
                    .environmentObject(windowServer)
                    .padding(.bottom, 10)
            }
            
            // Menu Bar
            VStack {
                MenuBar()
                Spacer()
            }
        }
        .preferredColorScheme(.dark)
    }
}

struct DesktopIcon: View {
    let name: String
    let icon: String
    
    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: icon)
                .font(.system(size: 48))
                .foregroundColor(.white)
                .shadow(color: .black.opacity(0.5), radius: 2, x: 0, y: 1)
            
            Text(name)
                .font(.system(size: 11))
                .foregroundColor(.white)
                .shadow(color: .black.opacity(0.8), radius: 1, x: 0, y: 1)
                .multilineTextAlignment(.center)
                .frame(width: 80)
        }
    }
}

#Preview {
    ContentView()
}
