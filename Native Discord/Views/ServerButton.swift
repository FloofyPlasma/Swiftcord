//
//  ServerButton.swift
//  Native Discord
//
//  Created by Vincent Kwok on 22/2/22.
//

import SwiftUI

struct ServerButtonStyle: ButtonStyle {
    let selected: Bool
    let name: String
    let bgColor: Color?
    @Binding var hovered: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            configuration.label.font(.system(size: 18))
        }
        .frame(width: 48, height: 48)
        .background(hovered || selected ? bgColor ?? Color("DiscordTheme") : .gray.opacity(0.25))
        .cornerRadius(hovered || selected ? 16 : 24, antialiased: true)
        .scaleEffect(configuration.isPressed ? 0.92 : 1)
        .animation(.interpolatingSpring(stiffness: 500, damping: 25), value: configuration.isPressed)
        .animation(.interpolatingSpring(stiffness: 500, damping: 30), value: hovered)
        .onHover { hover in hovered = hover }
    }
}

struct ServerButton: View {
    let selected: Bool
    let name: String
    // Not a good way to pass icons, but works
    let systemIconName: String?
    let assetIconName: String?
    let serverIconURL: String?
    let bgColor: Color?
    let onSelect: () -> Void
    @State private var hovered = false

    var body: some View {
        HStack {
            Capsule()
                .scale(selected || hovered ? 1 : 0)
                .fill(.white)
                .frame(width: 8, height: selected ? 40 : (hovered ? 20 : 8))
                .animation(.interpolatingSpring(stiffness: 500, damping: 30), value: selected)
                .animation(.interpolatingSpring(stiffness: 500, damping: 30), value: hovered)
                
            Button(action: { onSelect() }) {
                Text(systemIconName == nil && assetIconName == nil && serverIconURL == nil
                     ? name.split(separator: " ").map({ s in s.prefix(1)}).joined(separator: "")
                     : ""
                )
            }
            .buttonStyle(ServerButtonStyle(selected: selected, name: name, bgColor: bgColor, hovered: $hovered))
            /*.popover(isPresented: .constant(true)) {
                Text(name).padding(8)
            }*/
            .padding(.trailing, 8)
            
            Spacer()
        }
        .frame(width: 72, height: 48)
    }
}

struct ServerButton_Previews: PreviewProvider {
    static var previews: some View {
        ServerButton(
            selected: false,
            name: "Hello world, discord!",
            systemIconName: nil,
            assetIconName: nil,
            serverIconURL: nil,
            bgColor: nil,
            onSelect: {}
        )
    }
}