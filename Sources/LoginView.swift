import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        ZStack {
            AppTheme.background.ignoresSafeArea()
            
            VStack(spacing: 30) {
                // Logo & Title
                VStack(spacing: 12) {
                    Image(systemName: "cpu.fill")
                        .font(.system(size: 80))
                        .foregroundStyle(AppTheme.primary)
                    
                    Text("Zero sLLM")
                        .font(AppTheme.font(34, weight: .bold))
                        .foregroundColor(.white)
                    
                    Text("보안 중심 온프레미스 AI 솔루션")
                        .font(AppTheme.font(16))
                        .foregroundColor(.white.opacity(0.7))
                }
                .padding(.top, 60)
                
                // Login Form
                VStack(spacing: 15) {
                    CustomTextField(icon: "envelope", placeholder: "이메일", text: $email)
                    CustomTextField(icon: "lock", placeholder: "비밀번호", text: $password, isSecure: true)
                    
                    Button(action: {}) {
                        Text("로그인")
                            .font(AppTheme.font(18, weight: .bold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 56)
                            .background(AppTheme.primary)
                            .cornerRadius(16)
                            .shadow(color: AppTheme.primary.opacity(0.3), radius: 10, x: 0, y: 5)
                    }
                }
                .padding(.horizontal, 24)
                
                // Divider
                HStack {
                    Rectangle().frame(height: 1).foregroundColor(.white.opacity(0.1))
                    Text("또는").font(AppTheme.font(12)).foregroundColor(.white.opacity(0.5))
                    Rectangle().frame(height: 1).foregroundColor(.white.opacity(0.1))
                }
                .padding(.horizontal, 40)
                
                // Social Login
                VStack(spacing: 12) {
                    SocialLoginButton(icon: "apple.logo", title: "Apple로 계속하기", action: {})
                    SocialLoginButton(icon: "g.circle.fill", title: "Google로 계속하기", action: {})
                }
                .padding(.horizontal, 24)
                
                Spacer()
                
                NavigationLink(destination: SignUpView()) {
                    Text("계정이 없으신가요? 회원가입")
                        .font(AppTheme.font(14))
                        .foregroundColor(AppTheme.primary)
                }
                .padding(.bottom, 20)
            }
        }
    }

    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}

struct CustomTextField: View {
    let icon: String
    let placeholder: String
    @Binding var text: String
    var isSecure: Bool = false
    
    @State private var isShowingPassword: Bool = false
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(AppTheme.primary)
                .frame(width: 20)
            
            Group {
                if isSecure && !isShowingPassword {
                    SecureField("", text: $text, prompt: Text(placeholder).foregroundColor(.white.opacity(0.3)))
                } else {
                    TextField("", text: $text, prompt: Text(placeholder).foregroundColor(.white.opacity(0.3)))
                }
            }
            .frame(height: 24) // Consistent height for the input field itself
            
            if isSecure {
                Button(action: { isShowingPassword.toggle() }) {
                    Image(systemName: isShowingPassword ? "eye.slash" : "eye")
                        .foregroundColor(.white.opacity(0.5))
                        .font(.system(size: 14))
                }
            }
        }
        .padding()
        .background(AppTheme.cardBackground)
        .cornerRadius(12)
        .foregroundColor(.white)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.white.opacity(0.05), lineWidth: 1)
        )
    }
}

struct SocialLoginButton: View {
    let icon: String
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: icon)
                    .font(.body)
                Text(title)
                    .font(.body.weight(.medium))
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background(Color.white.opacity(0.05))
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.white.opacity(0.1), lineWidth: 1)
            )
            .cornerRadius(12)
        }
    }
}

#Preview {
    NavigationStack {
        LoginView()
    }
}
