import SwiftUI

struct ContentView: View {
    var body: some View {
        GridStack(rows: 4, columns: 4) { row, col in
            Text("R\(row) C\(col)").prominentStyle()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)

    }
}

struct GridStack<Content: View>: View {
    let rows: Int
    let columns: Int
    @ViewBuilder let content: (Int, Int) -> Content
    
    var body: some View {
        VStack() {
            ForEach(0..<rows, id: \.self) { row in
                HStack {
                    ForEach(0..<columns, id: \.self) { column in
                        content(row, column)
                    }
                }
                Spacer()
            }
        }
        .frame(maxHeight: .infinity)
    }
}

struct ProminentTextModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.blue)
    }
}

extension View {
    func prominentStyle() -> some View {
        modifier(ProminentTextModifier())
    }
}

#Preview {
    ContentView()
}
