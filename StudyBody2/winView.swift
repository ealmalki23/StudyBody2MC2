import SwiftUI
import AVKit

struct winView: View {
    @State private var player: AVPlayer?
    @State private var showNextScreen: Bool = false

    var body: some View {
        ZStack{
        VStack {
            if let player = player {
                VideoPlayer(player: player) {
                    // Optional: You can add additional video controls or overlay views here
                }
                .onAppear {
                    // Start playing the video automatically
                    player.play()
                    startRepeatingVideo()
                }
            }
        }
        .frame(width: 900, height: 900)
        .onAppear {
            // Initialize AVPlayer with your video file
            guard let url = Bundle.main.url(forResource: "final confitte", withExtension: "mov") else {
                return
            }
            self.player = AVPlayer(url: url)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            Color(red: 0.0274, green: 0.02352, blue: 0.137)
                .ignoresSafeArea()
        }
        .sheet(isPresented: $showNextScreen) {
            // Replace with your next view
            NextScreen()
        }
        
         
          VStack {
             
                Text("Math 101")
                    .font(.largeTitle)
                    .fontWeight(.light)
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 90.0)
                    
                
                Image("Trophy")
                    .resizable()
                    .frame(width:190, height:190)
                    .aspectRatio(contentMode: .fit)
                
                Text("Chocolate")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.center)
                    .padding(.top, 50.0)
                
                Text("Player")
                    .font(.title)
                    .fontWeight(.medium)
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.center)
                    
                
            }
            
            
            
        
    }/// for zstack
    }

    private func startRepeatingVideo() {
        // Repeat the video every 1 second
        let timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { _ in
            self.player?.seek(to: CMTime.zero)
            self.player?.play()
        }
        
        // After 20 seconds, show the next screen
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
            self.showNextScreen = true
            timer.invalidate() // Stop the repeating timer
        }
        
        // Add the timer to the common run loop
        RunLoop.current.add(timer, forMode: .common)
    }
}

struct NextScreen: View {
    var body: some View {
        Text("Next Screen")
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        winView()
    }
}
