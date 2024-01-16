//
//  HomeView.swift
//  UMCProject_Won
//
//  Created by 김승원 on 2024/01/10.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ScrollView(showsIndicators: false) {
            ZStack {
                Image("backgroundImage")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: UIScreen.main.bounds.width)
                    .position(x: UIScreen.main.bounds.width/2, y: 119) // 이거 y축 왜 0으로 하면 안 되는 거지?
                
                VStack(spacing: 0) {
                    HomeNavigationBar().padding(.top, 16)
                    UserInformation().padding(.top, 8)
                    NoticeLabel().padding(.top, 8)
                    MainCalender().padding(.top, 8)
                    ToDoList().padding(.top, 24)
                    
                    HStack(spacing: 18) {
                        TodayILearnd()
                        GitHub()
                    }
                    .padding(.top, 24)
                    
                    HStack(spacing: 18) {
                        Mascot()
                        Rank()
                    }
                    .padding(.top, 24)
                    .padding(.bottom, 24)
                }
            }
        }
        .background(Color.background)
    }
}

// MARK: - 홈화면_네비게이션 바
struct HomeNavigationBar: View {
    // 버튼 이름 리스트
    let imageNames: [String] = ["menuButtonImage",
                                "friendsButtonImage",
                                "noticeButtonImage",
                                "hammerButtonImage"]
    var body: some View {
        HStack {
            Button {                                                    // 왼쪽 메뉴 버튼
                print("\(imageNames[0]) Clicked")
            } label: {
                Image(imageNames[0])
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
            }
            .padding(.leading, 20)
            Spacer()
            
            HStack {                                                    // 오른쪽 버튼 3개
                ForEach(1..<imageNames.count, id: \.self) { index in
                    Button {
                        print("\(imageNames[index]) Clicked")
                    } label: {
                        Image(imageNames[index])
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20, height: 20)
                            .padding(.leading, 16)
                    }
                }
            }
            .padding(.trailing, 20)
        }
    }
}

// MARK: - 홈화면_유저 인포메이션
struct UserInformation: View {
    var body: some View {
        HStack {
            Image("univPictureEx")                                      // 학교 사진
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 36, height: 36)
                .clipShape(Circle())
                .background(Circle().foregroundColor(Color.white))
                .padding(.leading, 16)
            
            Text("가톨릭대학교")                                           // 학교 이름
                .foregroundColor(.white)
                .font(.system(size: 18, weight: .bold))
                .kerning(-1.07)
            
            Spacer()
            
            HStack(spacing: 0) {                                        // ( )님 반가워요!
                Text("원")
                    .foregroundColor(.white)
                    .font(.system(size: 16, weight: .bold))
                    // .kerning(-1.032)
                    
                Text("님 반가워요!")
                    .foregroundColor(.white)
                    .font(.system(size: 16))
                    // .kerning(-1.032)
            }
            .padding(.trailing, 16)
        }
    }
}

// MARK: - 홈화면_공지
struct NoticeLabel: View {
    var body: some View {
        ZStack {
            Rectangle()                                                 // 공지 배경
                .foregroundColor(Color.white)
                .cornerRadius(12)
                .frame(height: 28)
                .padding(.horizontal, 18)
            
            HStack(spacing: 0) {
                Image("earthImage")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 16, height: 16)
                    .padding(.leading, 26)
                
                Text("[연합]")
                    .foregroundStyle(Color.main2)
                    .font(.system(size: 16))
                    .kerning(-1.07)
                    .padding(.leading, 4)
                
                Text("12월 20일 회식 개최!")
                    .foregroundStyle(Color.black)
                    .font(.system(size:16))
                    .kerning(-1.07)
                    .padding(.leading, 2)
                
                Spacer()
                
            }
        }
    }
}

// MARK: - 캘린더
struct MainCalender: View {
    var body: some View {
        Rectangle()
            .foregroundColor(Color.white)
            .cornerRadius(12)
            .frame(height: 190)
            .padding(.horizontal, 18)
            .shadow(color: Color.gray.opacity(0.5), radius: 6, x: 0, y: 2)

        // 일단 Rectangle()
    }
}

// MARK: - 투두리스트
struct ToDoList: View {
    var TDLList : [String] = ["1", "2", "3"]
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("To - Do List")
                    .font(.system(size: 16, weight: .semibold))
                    .kerning(-1.07)
                    .foregroundStyle(Color.main2)
                    .padding(.leading, 18)
                
                Spacer()
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 0) {
                    ForEach(0..<3) { index in
                        ZStack {
                            Rectangle()
                                .frame(width: 122, height: 134)
                                .foregroundColor(Color.tdlDisabled)
                                .cornerRadius(20)
                                .padding(.leading, 18)
                            
                            VStack(spacing: 0) {
                                Button {
                                    print("TDLPlusButton Clicked")
                                } label: {
                                    Image(systemName: "plus.circle.fill")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 24, height: 24)
                                        .foregroundColor(Color.tdlGray)
                                        .offset(x: 8, y: 0)
                                }
                                .padding(.bottom, 8)
                                
                                VStack {                                // 글 VStack
                                    HStack(spacing: 0) {
                                        Text("원")
                                            .fontWeight(.semibold)
                                        Text("님의 투두를")
                                    }
                                    Text("기다리는 중이에요..😴")
                                }
                                .font(.system(size: 12))
                                .kerning(-1.05)
                                .padding(.leading, 18)
                            }
                        }
                    }
                }
                .padding(.trailing, 18)
            }
            .shadow(color: Color.gray.opacity(0.7), radius: 3, x: 0, y: 2)
            .padding(.top, 8)
        }
    }
}

// MARK: - 투데이 아이 런드
struct TodayILearnd: View {
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Text("Today I - Leanred")
                    .font(.system(size: 16, weight: .semibold))
                    .kerning(-1.05)
                    .foregroundStyle(Color.main2)
                
                Spacer()
            }
            .padding(.bottom, 12)
            ZStack {
                Rectangle()
                    .frame(height: 128)
                    .foregroundColor(Color.white)
                    .cornerRadius(12)
                    .shadow(color: Color.gray.opacity(0.25), radius: 6, x: 0, y: 2)
                
                VStack(spacing: 0) {
                    VStack(spacing: 0) {                                // 글 VStack
                        HStack(spacing: 0) {
                            Text("원")
                                .fontWeight(.semibold)
                            Text("님의")
                        }
                        Text("열공을 응원해요🔥")
                    }
                    .font(.system(size: 12))
                    .kerning(-1.05)
                    
                    Button {
                        print("TILButton Clicked")
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 24, height: 24)
                            .foregroundColor(Color.black)
                    }
                    .padding(EdgeInsets(top: 12, leading: 0, bottom: 8, trailing: 0))
                }
            }
        }
        .padding(.leading, 18)
    }
}
            
// MARK: - 깃허브

struct GitHub: View {
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Text("Today I - Leanred")
                    .font(.system(size: 16, weight: .semibold))
                    .kerning(-1.05)
                    .foregroundStyle(Color.main2)
                
                Spacer()
            }
            .padding(.bottom, 12)
            ZStack {
                Rectangle()
                    .frame(height: 128)
                    .foregroundColor(Color.white)
                    .cornerRadius(12)
                    .shadow(color: Color.gray.opacity(0.25), radius: 6, x: 0, y: 2)
                
                VStack(spacing: 0) {
                    VStack(spacing: 0) {                                // 글 VStack
                        HStack(spacing: 0) {
                            Text("깃허브")
                                .fontWeight(.semibold)
                            Text("를")
                        }
                        Text("연결해 주세요👾")
                    }
                    .font(.system(size: 12))
                    .kerning(-1.05)
                    
                    Button {
                        print("GitButton Clicked")
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 24, height: 24)
                            .foregroundColor(Color.black)
                    }
                    .padding(EdgeInsets(top: 12, leading: 0, bottom: 8, trailing: 0))
                }
            }
        }
        .padding(.trailing, 18)
    }
}
    

// MARK: - 마스코트
struct Mascot: View {
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Text("Mascot")
                    .font(.system(size: 16, weight: .semibold))
                    .kerning(-1.07)
                    .foregroundStyle(Color.main2)
                
                Spacer()
            }
            .padding(.bottom, 12)
            ZStack {
                Image("mascotRankBackgroundImage")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 160)
                    .cornerRadius(12.0)
                
                VStack(spacing: 0) {
                    Image("mascotImage")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 120)
                        .padding(.bottom, 5)
                }
            }
        }
        .padding(.leading, 18)
    }
}

// MARK: - 마스코트
struct Rank: View {
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Text("Rank")
                    .font(.system(size: 16, weight: .semibold))
                    .kerning(-1.07)
                    .foregroundStyle(Color.main2)
                Spacer()
            }
            .padding(.bottom, 12)
            ZStack {
                Image("mascotRankBackgroundImage")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 160)
                    .cornerRadius(12.0)
                
                VStack(spacing: 0) {
                    Image("userProfileEx")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                        .shadow(color: Color.gray.opacity(0.65), radius: 6, x: 0, y: 2)
                        .padding(.bottom, 5)
                    
                    VStack(spacing: 0) {                                // 글 Stack
                        HStack(spacing: 0) {
                            Text("원")
                                .fontWeight(.semibold)
                            Text("님은")
                        }
                        
                        HStack(spacing: 0) {
                            Text("현재")
                            Text("4등")
                                .fontWeight(.semibold)
                                .padding(.leading, 2)
                            Text("이에요!🫢")
                        }
                    }
                    .foregroundStyle(Color.white)
                    .font(.system(size: 12))
                    .kerning(-1.03)
                }
            }
        }
        .padding(.trailing, 18)
    }
}

#Preview {
    HomeView()
}
