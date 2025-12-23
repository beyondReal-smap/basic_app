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
                    Image(systemName: "shield.checkerboard")
                        .font(.system(size: 80))
                        .foregroundStyle(AppTheme.primary)
                    
                    Text("Zero sLLM")
                        .font(.system(size: 34, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                    
                    Text("Zero Trust On-premise AI")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.7))
                }
                .padding(.top, 60)
                
                // Login Form
                VStack(spacing: 15) {
                    CustomTextField(icon: "envelope", placeholder: "Email", text: $email)
                    CustomTextField(icon: "lock", placeholder: "Password", text: $password, isSecure: true)
                    
                    Button(action: {}) {
                        Text("Sign In")
                            .font(.headline)
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
                    Text("OR").font(.caption2).foregroundColor(.white.opacity(0.5))
                    Rectangle().frame(height: 1).foregroundColor(.white.opacity(0.1))
                }
                .padding(.horizontal, 40)
                
                // Social Login
                VStack(spacing: 12) {
                    SocialLoginButton(icon: "apple.logo", title: "Continue with Apple", action: {})
                    SocialLoginButton(icon: "g.circle.fill", title: "Continue with Google", action: {})
                }
                .padding(.horizontal, 24)
                
                Spacer()
                
                Button(action: {}) {
                    Text("Don't have an account? Sign Up")
                        .font(.footnote)
                        .foregroundColor(AppTheme.primary)
                }
                .padding(.bottom, 20)
            }
        }
    }
}

struct CustomTextField: View {
    let icon: String
    let placeholder: String
    @Binding var text: String
    var isSecure: Bool = false
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(AppTheme.primary)
                .frame(width: 20)
            
            if isSecure {
                SecureField("", text: $text, prompt: Text(placeholder).foregroundColor(.white.opacity(0.3)))
            } else {
                TextField("", text: $text, prompt: Text(placeholder).foregroundColor(.white.opacity(0.3)))
            }
        }
        .padding()
        .background(AppTheme.cardBackground)
        .cornerRadius(12)
        .foregroundColor(.white)
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
    LoginView()
}
