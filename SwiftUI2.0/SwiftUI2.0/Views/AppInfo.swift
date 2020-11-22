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

struct AppInfo_Previews: PreviewProvider {
    
    static let results = Results(
        name: "Facebook, Inc.",
        copyright: "© Facebook, Inc.",
        artworkUrl100: "https://is2-ssl.mzstatic.com/image/thumb/Purple124/v4/de/c6/66/dec66632-729d-db69-f3fb-5d21457adedf/Icon-Production-0-0-1x_U007emarketing-0-0-0-7-0-0-sRGB-0-0-0-GLES2_U002c0-512MB-85-220-0-0.png/200x200bb.png",
        releaseDate: "2019-02-05"
    )
    
    static var previews: some View {
        AppInfo(app: results)
            .preferredColorScheme(.dark)
            .previewLayout(.fixed(width: 150, height: 200))
            
    }
}
