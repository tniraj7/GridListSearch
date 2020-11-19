import SwiftUI

struct SearchBar: View {
    
    @Binding var isSearching: Bool
    @Binding var searchText: String
    
    var body: some View {

        HStack {
            HStack {
                TextField("Search apps here", text: $searchText)
                    .padding(.leading, 24 )
            }
            .padding()
            .background(Color(.systemGray5))
            .cornerRadius(8)
            .padding(.horizontal)
            .onTapGesture {
                isSearching = true
            }
            .overlay (
                HStack {
                    Image(systemName: "magnifyingglass")
                    Spacer()
                    if isSearching {
                        Button(action: {
                            searchText = ""
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .padding(.vertical)
                        }
                    }
                }
                .padding(.horizontal, 32)
                .foregroundColor(.gray)
            )
            .transition(.move(edge: .trailing))
            .animation(.spring())
            
            if isSearching {
                Button(action: {
                    isSearching = false
                    searchText = ""
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }, label: {
                    Text("Cancel")
                        .padding(.trailing)
                })
                .transition(.move(edge: .trailing))
                .animation(.spring())
            }
        }
    }
}
