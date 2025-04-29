//
//  ContentView.swift
//  SettingViewAccessibility
//
//  Created by BEYZA KARADENIZ on 26.04.2025.
//

import SwiftUI

struct GroupedInfoRow: View {
    let title: String
    let value: String

    var body: some View {
        HStack {
            Text(title)
                .font(.body)
            Spacer()
            Text(value)
                .font(.body)
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 8)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("\(title), \(value)")
    }
}

struct SettingsView: View {
    @State private var searchText = ""
    @State private var isAirplaneModeOn = false

    var body: some View {
        NavigationView {
            List {
                // MARK: – Profile Row
                Button(action: { /* Account details */ }) {
                    HStack(spacing: 16) {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .clipShape(Circle())
                            .accessibilityHidden(true)

                        VStack(alignment: .leading, spacing: 4) {
                            Text("Beyza Karadeniz")
                                .font(.headline)
                                .accessibilityHidden(true)
                            Text("Apple Account, iCloud, and more")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                                .accessibilityHidden(true)
                        }

                        Spacer()

                        Image(systemName: "chevron.right")
                            .foregroundColor(.gray)
                            .accessibilityHidden(true)
                    }
                    .padding(.vertical, 8)
                }
                .accessibilityElement(children: .ignore)
                .accessibilityLabel("Apple account and iCloud settings")
                .accessibilityHint("Tap to view account details")

                // MARK: – Promotion Row
                Button(action: { /*  */ }) {
                    HStack {
                        Text("Get 3 Months Free Apple Music")
                            .font(.body)
                            .accessibilityHidden(true)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(.gray)
                            .accessibilityHidden(true)
                    }
                    .padding(.vertical, 8)
                }
                .accessibilityElement(children: .ignore)
                .accessibilityLabel("Three months free Apple Music promotion")
                .accessibilityHint("Tap to view promotion details")

                // MARK: – Connection Settings Section
                Section(header:
                    Text("Connection Settings")
                        .accessibilityAddTraits(.isHeader)
                ) {
                    // Airplane Mode (Adjustable Example)
                    Toggle(isOn: $isAirplaneModeOn) {
                        Label("Airplane Mode", systemImage: "airplane")
                            .accessibilityHidden(true)
                    }
                    .accessibilityLabel("Airplane Mode")
                    .accessibilityValue(isAirplaneModeOn ? "On" : "Off")
                    .accessibilityAdjustableAction { dir in
                        switch dir {
                        case .increment: isAirplaneModeOn = true
                        case .decrement: isAirplaneModeOn = false
                        default: break
                        }
                    }
                    .accessibilityHint("Swipe up or down with three fingers to toggle")

                    // Wi-Fi (GroupedInfoRow + chevron)
                    NavigationLink(destination: Text("Wi-Fi Settings")) {
                        HStack {
                            GroupedInfoRow(title: "Wi-Fi", value: "XXXX")
                            Image(systemName: "chevron.right")
                                .accessibilityHidden(true)
                        }
                    }
                    .accessibilityHint("Tap to open Wi-Fi settings")

                    // Bluetooth
                    NavigationLink(destination: Text("Bluetooth Settings")) {
                        HStack {
                            GroupedInfoRow(title: "Bluetooth", value: "On")
                            Image(systemName: "chevron.right")
                                .accessibilityHidden(true)
                        }
                    }
                    .accessibilityHint("Tap to open Bluetooth settings")
                }

                // MARK: – Other Settings Section
                Section(header:
                    Text("Other Settings")
                        .accessibilityAddTraits(.isHeader)
                ) {
                    NavigationLink(destination: Text("General Settings")) {
                        Label("General", systemImage: "gearshape")
                            .accessibilityHidden(false)
                    }
                    .accessibilityHint("Tap to open general settings")

                    NavigationLink(destination: Text("Accessibility Settings")) {
                        Label("Accessibility", systemImage: "figure.wave")
                            .accessibilityHidden(false)
                    }
                    .accessibilityHint("Tap to open accessibility settings")
                }

                // MARK: – Additional Info Section
                Section(header:
                    Text("Additional Info")
                        .accessibilityAddTraits(.isHeader)
                ) {
                    GroupedInfoRow(title: "Full Name", value: "Beyza Karadeniz")
                }
            }
            .listStyle(InsetGroupedListStyle())
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search in Settings")
            .accessibilityLabel("Search in Settings")
            .accessibilityHint("Double tap and type to search")
            .accessibilityAddTraits(.isSearchField)
            .navigationTitle("Settings")
        }
    }
}
