# MaciOS

A macOS 26 Tahoe simulator for iPhone, built with SwiftUI.

## Overview

MaciOS is an iOS application that simulates the macOS experience on iPhone, featuring the "Liquid Glass" design language with translucent materials, gradients, and rounded corners.

## Project Structure

```
MaciOS/
├── MaciOSApp.swift              # App entry point
├── Info.plist                   # iOS app configuration
├── Models/
│   └── WindowModel.swift        # AppWindow struct & WindowServer class
└── Views/
    ├── ContentView.swift        # Main desktop container
    └── Components/
        ├── MenuBar.swift        # Top menu bar with Apple logo and status items
        ├── DockView.swift       # Bottom dock with app icons
        └── WindowView.swift     # Draggable window wrapper component
```

## Architecture

- **MVVM Pattern**: Models, Views, and ViewModels are separated for maintainability
- **WindowServer**: Centralized window management system (ObservableObject)
- **AppWindow**: Model representing individual application windows

## Features

- **Menu Bar**: Top bar with Apple logo, menus (File, Edit, View, Go, Window, Help), and status items (WiFi, Battery, Time)
- **Dock**: Bottom floating dock with app icons using ultra-thin material
- **Windows**: Draggable windows with traffic light controls (Close, Minimize, Maximize)
- **Desktop**: Gradient wallpaper inspired by macOS Tahoe with desktop icons
- **Liquid Glass**: Extensive use of `.ultraThinMaterial` for authentic macOS appearance

## Requirements

- iOS 15.0+
- Xcode 13.0+
- Swift 5.5+

## Getting Started

1. Open the project in Xcode
2. Select your target device or simulator
3. Build and run the project
4. Tap dock icons to open simulated app windows
5. Drag windows by their title bar
6. Use traffic light buttons to close or minimize windows
