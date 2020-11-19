import SwiftUI
import SDWebImageSwiftUI


struct AppInfo: View {
    
    let app: Results
    
    init(app: Results) {
        self.app = app
    }
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 4) {
            
            WebImage(url: URL(string: app.artworkUrl100))
                .resizable()
                .indicator(.activity)
                .transition(.fade(duration: 0.5))
                .scaledToFit()
                .cornerRadius(20)
            
            Text(app.name)
                .font(.system(size: 12))
                .fontWeight(.semibold)
                .padding(.top, 4)
            
            Text(app.releaseDate)
                .font(.system(size: 10))
                .fontWeight(.semibold)
            
            if let copyright = app.copyright {
                Text(copyright)
                    .font(.system(size: 9))
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
        }.padding()
    }
}
