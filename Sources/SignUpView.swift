import SwiftUI

struct SignUpView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel = AuthViewModel()
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    
    // Validation states
    private var isEmailValid: Bool { isValidEmail(email) }
    private var isPasswordLongEnough: Bool { password.count >= 9 }
    private var hasUpperCase: Bool { password.rangeOfCharacter(from: .uppercaseLetters) != nil }
    private var hasLowerCase: Bool { password.rangeOfCharacter(from: .lowercaseLetters) != nil }
    private var hasSpecialChar: Bool { password.rangeOfCharacter(from: CharacterSet(charactersIn: "!@#$%^&*()_+-=[]{}|;':\",./<>?")) != nil }
    private var isPasswordValid: Bool { isPasswordLongEnough && hasUpperCase && hasLowerCase && hasSpecialChar }
    private var isConfirmValid: Bool { !password.isEmpty && password == confirmPassword }

    var body: some View {
        ZStack {
            AppTheme.background.ignoresSafeArea()
            
            VStack(spacing: 25) {
                // Header
                VStack(spacing: 12) {
                    Text("계정 생성")
                        .font(AppTheme.font(34, weight: .bold))
                        .foregroundColor(.white)
                    
                    Text("Zero Trust sLLM 네트워크에 참여하세요")
                        .font(AppTheme.font(16))
                        .foregroundColor(.white.opacity(0.7))
                }
                .padding(.top, 30)
                
                // Form
                ScrollView {
                    VStack(spacing: 15) {
                        CustomTextField(icon: "person", placeholder: "성함", text: $name)
                        
                        VStack(alignment: .leading, spacing: 6) {
                            CustomTextField(icon: "envelope", placeholder: "이메일 주소", text: $email)
                            if !email.isEmpty {
                                ValidationRow(isValid: isEmailValid, text: "올바른 이메일 형식")
                            }
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            CustomTextField(icon: "lock", placeholder: "비밀번호", text: $password, isSecure: true)
                            
                            if !password.isEmpty {
                                VStack(alignment: .leading, spacing: 4) {
                                    ValidationRow(isValid: isPasswordLongEnough, text: "9자리 이상")
                                    ValidationRow(isValid: hasUpperCase, text: "대문자 포함")
                                    ValidationRow(isValid: hasLowerCase, text: "소문자 포함")
                                    ValidationRow(isValid: hasSpecialChar, text: "특수문자 포함")
                                }
                                .padding(.leading, 4)
                            }
                        }
                        
                        VStack(alignment: .leading, spacing: 6) {
                            CustomTextField(icon: "lock.shield", placeholder: "비밀번호 확인", text: $confirmPassword, isSecure: true)
                            if !confirmPassword.isEmpty {
                                ValidationRow(isValid: isConfirmValid, text: "비밀번호 일치")
                            }
                        }
                        
                        if let error = viewModel.errorMessage {
                            Text(error)
                                .font(AppTheme.font(12))
                                .foregroundColor(.red)
                                .padding(.top, 5)
                        }
                        
                        Button(action: {
                            Task {
                                if !isEmailValid {
                                    viewModel.errorMessage = "유효한 이메일을 입력해주세요."
                                } else if !isPasswordValid {
                                    viewModel.errorMessage = "비밀번호 조건을 충족해주세요."
                                } else if !isConfirmValid {
                                    viewModel.errorMessage = "비밀번호가 일치하지 않습니다."
                                } else {
                                    let success = await viewModel.register(name: name, email: email, password: password)
                                    if success {
                                        dismiss()
                                    }
                                }
                            }
                        }) {
                            if viewModel.isLoading {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            } else {
                                Text("회원가입")
                                    .font(AppTheme.font(18, weight: .bold))
                            }
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(isEmailValid && isPasswordValid && isConfirmValid ? AppTheme.primary : AppTheme.primary.opacity(0.3))
                        .cornerRadius(16)
                        .shadow(color: AppTheme.primary.opacity(0.3), radius: 10, x: 0, y: 5)
                        .disabled(viewModel.isLoading || !(isEmailValid && isPasswordValid && isConfirmValid))
                        .padding(.top, 10)
                    }
                    .padding(.horizontal, 24)
                }
                
                Button(action: { dismiss() }) {
                    Text("이미 계정이 있으신가요? 로그인")
                        .font(AppTheme.font(14))
                        .foregroundColor(AppTheme.primary)
                }
                .padding(.bottom, 20)
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { dismiss() }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.white)
                }
            }
        }
    }
}

struct ValidationRow: View {
    let isValid: Bool
    let text: String
    
    var body: some View {
        HStack(spacing: 5) {
            Image(systemName: isValid ? "checkmark.circle.fill" : "circle")
                .font(.caption2)
            Text(text)
                .font(AppTheme.font(12))
        }
        .foregroundColor(isValid ? .green : .white.opacity(0.4))
    }
}
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}

#Preview {
    NavigationStack {
        SignUpView()
    }
}
