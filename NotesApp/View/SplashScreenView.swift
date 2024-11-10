import SwiftUI

struct SplashScreenView: View {
    @State private var isActive:Bool = false
    @State private var opacity = 0.0
    @State private var scaleEffect = 0.8
    var body: some View {
        ZStack{
            Color.black
                .ignoresSafeArea()
            
            Image("New Apple Logo")
                .resizable()
                .scaledToFit()
                .ignoresSafeArea()
                .scaleEffect(scaleEffect)
                .opacity(opacity)
                .frame(width:170, height:900, alignment: .center)
                .background(.black)
                .onAppear{
                    withAnimation(.easeInOut(duration: 1.5)){
                        self.scaleEffect = 1.9
                        self.opacity = 1.0
                        
                    }
                    //delay the transition to main view
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
                        withAnimation{
                            self.isActive = true
                        }
                    }
                }
            
        }// ZStack
        .fullScreenCover(isPresented: $isActive){
            ContentView()
        }
    }
}

#Preview {
    SplashScreenView()
}
