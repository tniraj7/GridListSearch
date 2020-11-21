import SwiftUI

struct ContentView: View {
    
    private let navTitle = "Grid List Search"
    @State var searchText = ""
    @State var isSearching = Bool()
    @ObservedObject var vm = GridViewModel()
    
    var body: some View {
        
        NavigationView {
            
            if vm.isLoading {
                ProgressView()
                    .navigationTitle(navTitle)
            } else {
                ScrollView {
                    SearchBar(isSearching: $isSearching, searchText: $searchText)
                    
                    LazyVGrid(columns: [
                        GridItem(.flexible(minimum: 100, maximum: 200), spacing: 0, alignment: .top),
                        GridItem(.flexible(minimum: 100, maximum: 200), spacing: 0, alignment: .top),
                        GridItem(.flexible(minimum: 100, maximum: 200), spacing: 0)
                    ], alignment: .leading, spacing: 5, content: {
                        
                        ForEach(vm.results.filter{ "\($0)".contains(searchText) || searchText.isEmpty }, id: \.self) { app in
                            AppInfo(app: app)
                                .animation(.spring())
                        }
                        
                    }).padding(.horizontal, 12)
                }
                .navigationTitle(navTitle)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
            .previewDevice("iPhone 11")
    }
}
