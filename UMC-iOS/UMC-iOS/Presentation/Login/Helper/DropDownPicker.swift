//
//  DropDownPicker.swift
//  UMC-iOS
//
//  Created by 이태현 on 1/10/24.
//

import SwiftUI

enum DropDownPickerState {
    case top
    case bottom
}

struct DropDownPicker: View {
    
    @Binding var selection: String?
    var state: DropDownPickerState = .bottom
    var options: [String]
    var maxWidth: CGFloat = 272
    var placeholder: String = ""
    
    @State var showDropdown = false
    
    @SceneStorage("drop_down_zindex") private var index = 1000.0
    @State var zindex = 1000.0
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            VStack(spacing: 0) {
                
                if state == .top && showDropdown {
                    OptionsView()
                }
                
                HStack {
                    Spacer()
                    
                    Text(selection == nil ? placeholder : selection!)
                        .foregroundColor(selection != nil ? .black : .gray)
                        .multilineTextAlignment(.center)
                    
                    Spacer(minLength: 0)
                    
                    Image(systemName: state == .top ? "chevron.up" : "chevron.down")
                        .font(.title3)
                        .foregroundColor(.gray)
                        .rotationEffect(.degrees((showDropdown ? -180 : 0)))
                }
                .padding(.horizontal, 15)
                .frame(width: 272, height: 40)
                .background(.white)
                .contentShape(.rect)
                .onTapGesture {
                    index += 1
                    zindex = index
                    withAnimation(.snappy) {
                        showDropdown.toggle()
                    }
                }
                .zIndex(10)
                                
                if state == .bottom && showDropdown {
                    OptionsView()
                }
            }
            .clipped()
            .background(.white)
            .cornerRadius(12)
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.gray)
            }
            .frame(height: size.height, alignment: state == .top ? .bottom : .top)
            
        }
        .frame(width: maxWidth, height: 40)
        .zIndex(zindex)
    }
    
    
    func OptionsView() -> some View {
        VStack{
            ScrollView{
                HStack{
                    Spacer()
                    VStack(spacing: 0) {
                        ForEach(options, id: \.self) { option in
                            Text(option)
                                .multilineTextAlignment(.center)
                                .foregroundStyle(selection == option ? Color.black : Color.gray)
                                .animation(.none, value: selection)
                                .frame(height: 40)
                                .contentShape(.rect)
                                .onTapGesture {
                                    withAnimation(.snappy) {
                                        selection = option
                                        showDropdown.toggle()
                                    }
                                }
                        }
                    }
                    Spacer()
                }
            }
            .frame(minHeight: 500)
            
        }
        .transition(.move(edge: state == .top ? .bottom : .top))
        .zIndex(1)
    }
}
