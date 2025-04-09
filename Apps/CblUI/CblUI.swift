// (C) 2025 Alexander Voß, a.voss@fh-aachen.de, info@codebasedlearning.dev

import SwiftUI

/**
 Some theme-related constants
 */
public struct CblTheme {
    public static let red = fromHex(hex: "#941100")
    public static let light = fromHex(hex: "#A8ADFF")
    public static let medium = fromHex(hex: "#8789CA")
    public static let dark = fromHex(hex: "#363752")

    public static func fromHex(hex: String) -> Color {
        let cleanedHex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        let hexValue: String

        switch cleanedHex.count {
        case 3: hexValue = cleanedHex.map { "\($0)\($0)" }.joined()
        case 6: hexValue = cleanedHex
        default: return .gray
        }

        var rgb: UInt64 = 0
        guard Scanner(string: hexValue).scanHexInt64(&rgb) else { return .gray }

        let red = Double((rgb & 0xFF0000) >> 16) / 255
        let green = Double((rgb & 0x00FF00) >> 8) / 255
        let blue = Double(rgb & 0x0000FF) / 255
        return Color(red: red, green: green, blue: blue)
    }
}


//----------


/**
 Base Screen-View with some fixed constants for CblFullScreenBackground.
 */
public struct CblScreen<Content: View>: View {
    let title: String
    let image: String?
    let content: Content
    
    public init(title: String, image: String? = nil, @ViewBuilder content: () -> Content) {
        self.title = title
        self.image = image
        self.content = content()
    }
    
    public var body: some View {
        ZStack {
            CblFullScreenBackground(background: (color: CblTheme.dark, opacity: 0.5),
                                    image: (name: image, opacity: 0.2))
            VStack(spacing: 0) {
                CblTitle(text: title)
                content
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    // border check: .border(Color.red, width: 1)
            }
        }
    }
}

#Preview("screen") {
    CblScreen(title: "- Topic -") {
        Text("- content -")
    }
}


//----------


/**
 Screen-title.
 */
public struct CblTitle: View {
    @Environment(\.colorScheme) var colorScheme
    
    let text: String

    public init(text: String) {
        self.text = text
    }

    public var body: some View {
        VStack(spacing: 0) {
            Color.clear.frame(height: 1)
            Text(text)
                .font(.title2)
                .bold(true)
                .frame(maxWidth: .infinity)
                .foregroundColor(CblTheme.light)
                .background(CblTheme.red.opacity(0.8))
                .border(CblTheme.light, width: 1)
        }
    }
}

#Preview("world") {
    CblTitle(text: "Hello, World!")
}

#Preview("course") {
    CblTitle(text: "Hello, Course!")
}


//----------


/**
 Composes a background color, with opacity, and an image, also with opacity, full screen.
 */
public struct CblFullScreenBackground: View {
    public typealias BackgroundStyle = (color: Color, opacity: Double)
    public typealias ImageAppearance = (name: String?, opacity: Double)
    public typealias ImageTransformation = (scale: CGFloat, offset: (x: CGFloat, y: CGFloat))
    let background: BackgroundStyle //(color: Color, opacity: Double)
    let image: ImageAppearance
    let transformation: ImageTransformation
    
    public init(
        background: BackgroundStyle = (.clear, 0.2),
        image: ImageAppearance = (nil, 0.2),
        transformation: ImageTransformation = (1, (0, 0))
    ) {
        self.background = background
        self.image = image
        self.transformation = transformation
    }

    public var body: some View {
        GeometryReader { geometry in
            if let imageName = image.name {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .scaleEffect(transformation.scale)
                    .offset(x: transformation.offset.x, y: transformation.offset.y)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .clipped()
                    .opacity(image.opacity)
                    .background(background.color)
                    .opacity(background.opacity)
            } else {
                Color.clear.frame(width: geometry.size.width,
                                  height: geometry.size.height)
                .background(background.color)
                .opacity(background.opacity)
            }
        }
        .ignoresSafeArea()
    }
}

#Preview("background") {
    CblFullScreenBackground(background: (color: Color.red, opacity: 0.2))
}
