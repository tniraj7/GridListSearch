import SwiftUI
import KingfisherSwiftUI


struct AppInfo: View {
    
    let app: Results
    
    init(app: Results) {
        self.app = app
    }
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 4) {
            
            KFImage(URL(string: app.artworkUrl100)!)
                .resizable()
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
