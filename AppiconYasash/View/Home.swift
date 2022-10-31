//
//  Home.swift
//  AppiconYasash
//
//  Created by Waris Ruzi on 2022/10/31.
//

import SwiftUI

struct Home: View {
    @StateObject var iconModel: IconViewModel  = IconViewModel()
    
    //MARK: Environment Values for adopting UI for dark/light mode
    @Environment(\.self) var env
    var body: some View {
        
        VStack(spacing: 15){
            if let image = iconModel.pickedImage{
                //MARK: Displaying Image with Action
                Group {
                    Image(nsImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 250, height: 250)
                        .clipped()
                        .onTapGesture(perform: iconModel.PickImage)
                    
                    //MARK: Generate Button
                    Button {
                        iconModel.generateIconSet()
                    } label: {
                        Text("ئايكون ھاسىل قىلىش")
                            .font(.custom(Uyghur, size: 18))
                            .foregroundColor(env.colorScheme == .dark ? .black : .white)
                            .padding(.vertical,8)
                            .padding(.horizontal,18)
                            .background(.primary, in: RoundedRectangle(cornerRadius: 10))
                    }
                    .padding(.top, 10)

                    
                }
            }
            else  {
                // MARK: Add Button
                ZStack{
                    Button {
                        iconModel.PickImage()
                    } label: {
                        Image(systemName: "plus")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(env.colorScheme == .dark ? .black : .white)
                            .padding(15)
                            .background(.primary, in: RoundedRectangle(cornerRadius: 10))
                    }
                    
                    // Recommended Size Text
                    Text(" 1024 X 1024 \n رازمىردىكى رەسىم تەۋسىيە قىلىندۇ  ")
                        .font(.custom(Uyghur, size: 18))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.gray)
                        .padding(.bottom, 10)
                        .frame(maxHeight: .infinity, alignment: .bottom)

                }
            }
            
        }
        .frame(width: 400, height: 400)
        .buttonStyle(.plain)
        //MARK: ALERT VIEW
        .alert(iconModel.alertMsg, isPresented: $iconModel.showAlert) {
            
        }
        //MARK: Loading View
        .overlay {
            ZStack{
                if iconModel.isGenerating{
                    Color.black
                        .opacity(0.25)
                    
                    ProgressView()
                        .padding()
                        .background(.white, in: RoundedRectangle(cornerRadius: 10))
                        .environment(\.colorScheme, .light)
                    
                }
            }
        }
        .animation(.easeInOut, value: iconModel.isGenerating)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
