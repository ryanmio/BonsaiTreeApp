import SwiftUI
import RichTextKit

struct RichTextEditorView: View {
    @Binding var text: NSAttributedString

    let context: RichTextContext

    var body: some View {
        RichTextEditor(text: $text, context: context)
            .padding()
            .background(Color(UIColor.systemGray6))
            .cornerRadius(8)
    }
}

struct RichTextEditorView_Previews: PreviewProvider {
    static var previews: some View {
        RichTextEditorView(text: .constant(NSAttributedString(string: "Sample Text")), context: RichTextContext())
    }
}