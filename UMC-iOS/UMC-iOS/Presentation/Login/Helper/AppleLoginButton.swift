//
//  AppleLoginButton.swift
//  UMC-iOS
//
//  Created by 이태현 on 2/5/24.
//

import SwiftUI

struct AppleLoginButton: View {
    @EnvironmentObject var loginViewModel: LoginViewModel
    @EnvironmentObject var userViewModel: UserViewModel
    @Binding var isLoggedIn: Bool
    @Binding var alreadyMember: Bool
    
    var body: some View {
        loginViewModel.appleLoginButton() {
            if loginViewModel.isLoggedIn {
                userViewModel.joinMember(socialToken: loginViewModel.socialToken) {
                    alreadyMember = userViewModel.user.is_service_member!
                    isLoggedIn = true
                }
            } else {
                isLoggedIn = false
            }
        }
    }
}
