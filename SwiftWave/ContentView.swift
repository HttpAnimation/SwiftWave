import SwiftUI
import WebKit

struct BrowserView: UIViewRepresentable {
    let url: URL
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        if let urlString = URL(string: "https://www.google.com") {
            let request = URLRequest(url: urlString)
            webView.load(request)
        }
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        // Update the view
    }
}

struct ContentView: View {
    @State private var urlString: String = ""
    @State private var showingAlert = false
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter URL", text: $urlString, onCommit: {
                    if let url = URL(string: self.urlString) {
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    } else {
                        self.showingAlert = true
                    }
                })
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                
                BrowserView(url: URL(string: urlString)!)
                    .navigationBarTitle(Text(urlString), displayMode: .inline)
                    .alert(isPresented: $showingAlert) {
                        Alert(title: Text("Invalid URL"), message: Text("Please enter a valid URL"), dismissButton: .default(Text("OK")))
                    }
                
                Spacer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
