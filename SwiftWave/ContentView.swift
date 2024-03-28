import SwiftUI
import WebKit

struct ContentView: View {
    @State private var urlString = ""
    @State private var webView: WKWebView?

    var body: some View {
        VStack {
            TextField("Enter URL", text: $urlString, onCommit: loadWebPage)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            if let webView = webView {
                WebView(webView: webView)
            }
        }
        .onAppear(perform: {
            let webView = WKWebView()
            self.webView = webView
            loadWebPage()
        })
        .padding()
    }
    
    func loadWebPage() {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            webView?.load(request)
        }
    }
}

struct WebView: NSViewRepresentable {
    let webView: WKWebView
    
    func makeNSView(context: Context) -> WKWebView {
        return webView
    }
    
    func updateNSView(_ nsView: WKWebView, context: Context) {
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
