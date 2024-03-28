import SwiftUI
import WebKit

struct BrowserView: View {
    @State private var urlString: String = ""
    @State private var showingAlert = false
    @State private var webView: WKWebView = WKWebView()
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter URL", text: $urlString, onCommit: {
                    if let url = URL(string: self.urlString) {
                        self.load(url: url)
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    } else {
                        self.showingAlert = true
                    }
                })
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                
                WebView(webView: webView)
                    .navigationBarTitle(Text(urlString), displayMode: .inline)
                    .alert(isPresented: $showingAlert) {
                        Alert(title: Text("Invalid URL"), message: Text("Please enter a valid URL"), dismissButton: .default(Text("OK")))
                    }
                
                Spacer()
            }
        }
    }
    
    private func load(url: URL) {
        let request = URLRequest(url: url)
        webView.load(request)
    }
}

struct WebView: UIViewRepresentable {
    let webView: WKWebView
    
    func makeUIView(context: Context) -> WKWebView {
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        // Update the view
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        BrowserView()
    }
}
