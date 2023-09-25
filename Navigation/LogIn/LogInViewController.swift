//
//  LogInViewController.swift
//  Navigation
//
//  Created by Алексей Калинин on 30.01.2023.
//

import UIKit
import FirebaseAuth
import RealmSwift

class LogInViewController: UIViewController {

    let tabBar = UITabBarItem(title: "Profile".localized,
                              image: UIImage(systemName: "person"),
                              selectedImage: UIImage(systemName: "person.fill"))

    var delegate: LoginViewControllerDelegate?

    static var logInError: String?
    static var signUpError: String?
    
    let authService = LocalAuthorizationService()
    
    var isLogin: Bool = false

    private let notificationCenter = NotificationCenter.default

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private let contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()

    private let logoImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "logo")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private let loginStackView: UIStackView = {
        let loginStackView = UIStackView()
        loginStackView.axis = .vertical
        loginStackView.layer.borderColor = UIColor.lightGray.cgColor
        loginStackView.layer.borderWidth = 0.5
        loginStackView.layer.cornerRadius = 10
        loginStackView.clipsToBounds = true
        loginStackView.translatesAutoresizingMaskIntoConstraints = false
        return loginStackView
    }()

    private lazy var loginTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.textColor = Palette.blackWhite
        textField.backgroundColor = Palette.gray62
        textField.placeholder = "Email"
        textField.keyboardType = .emailAddress
        textField.tintColor = UIColor(named: "#4885CC")
        textField.autocapitalizationType = .none
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 0.25
        textField.leftViewMode = .always
        textField.returnKeyType = .done
        textField.clearButtonMode = .whileEditing
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.textColor = Palette.blackWhite
        textField.backgroundColor = Palette.gray62
        textField.placeholder = "Password".localized
        textField.isSecureTextEntry = true
        textField.tintColor = UIColor(named: "#4885CC")
        textField.autocapitalizationType = .none
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 0.25
        textField.leftViewMode = .always
        textField.returnKeyType = .done
        textField.clearButtonMode = .whileEditing
        textField.isSecureTextEntry = true
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log In".localized, for: .normal)
        button.setTitleColor(Palette.whiteBlack, for: .normal)
        button.setBackgroundImage(UIImage(named: "blue_pixel")!.alpha(1), for: .normal)
        button.setBackgroundImage(UIImage(named: "blue_pixel")!.alpha(0.8), for: .selected)
        button.setBackgroundImage(UIImage(named: "blue_pixel")!.alpha(0.8), for: .highlighted)
        button.setBackgroundImage(UIImage(named: "blue_pixel")!.alpha(0.8), for: .disabled)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.addTarget(nil, action: #selector(loginButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up".localized, for: .normal)
        button.setTitleColor(Palette.whiteBlack, for: .normal)
        button.backgroundColor = .orange
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.addTarget(nil, action: #selector(signUpButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var brutePasswordButton: UIButton = {
        let button = UIButton()
        button.setTitle("Find a password".localized, for: .normal)
        button.setTitleColor(Palette.whiteBlack, for: .normal)
        button.setBackgroundImage(UIImage(named: "blue_pixel")!.alpha(1), for: .normal)
        button.setBackgroundImage(UIImage(named: "blue_pixel")!.alpha(0.8), for: .selected)
        button.setBackgroundImage(UIImage(named: "blue_pixel")!.alpha(0.8), for: .highlighted)
        button.setBackgroundImage(UIImage(named: "blue_pixel")!.alpha(0.8), for: .disabled)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.addTarget(nil, action: #selector(brutePasswordButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var faceIDButton: CustomButton = {
        var button = CustomButton(title: "", titleColor: .clear, backgroundColor: .clear, onTap: biometricsButtonTapped)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = UIActivityIndicatorView.Style.large
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()

    init(){
        super.init(nibName: nil, bundle: nil)
        tabBarItem = tabBar
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Palette.whiteBlack
        navigationController?.navigationBar.isHidden = true

        setupViews()
    }

    private func setupViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.keyboardDismissMode = .interactive

        contentView.addSubviews(logoImage, loginStackView, loginButton, signUpButton, brutePasswordButton, faceIDButton, activityIndicator)

        loginStackView.addArrangedSubview(loginTextField)
        loginStackView.addArrangedSubview(passwordTextField)

        loginTextField.delegate = self
        passwordTextField.delegate = self

        constraints()
        notifications()
        hideKeyboard()
        biometricsButton()
    }

    private func constraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
//            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            contentView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),

            logoImage.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 120),
            logoImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            logoImage.heightAnchor.constraint(equalToConstant: 100),
            logoImage.widthAnchor.constraint(equalToConstant: 100),

            loginStackView.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 120),
            loginStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            loginStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            loginStackView.heightAnchor.constraint(equalToConstant: 100),

            loginTextField.heightAnchor.constraint(equalToConstant: 50),

            passwordTextField.heightAnchor.constraint(equalToConstant: 50),

            loginButton.topAnchor.constraint(equalTo: loginStackView.bottomAnchor, constant: 16),
            loginButton.leadingAnchor.constraint(equalTo: loginStackView.leadingAnchor),
            loginButton.trailingAnchor.constraint(equalTo: loginStackView.trailingAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            loginButton.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -16),

            signUpButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 16),
            signUpButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            signUpButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            signUpButton.heightAnchor.constraint(equalToConstant: 50),

            brutePasswordButton.topAnchor.constraint(equalTo: signUpButton.bottomAnchor, constant: 16),
            brutePasswordButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            brutePasswordButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            brutePasswordButton.heightAnchor.constraint(equalToConstant: 50),
            
            faceIDButton.topAnchor.constraint(equalTo: brutePasswordButton.bottomAnchor, constant: 16),
            faceIDButton.centerXAnchor.constraint(equalTo: brutePasswordButton.centerXAnchor),
            faceIDButton.widthAnchor.constraint(equalToConstant: 40),
            faceIDButton.heightAnchor.constraint(equalToConstant: 40),

            activityIndicator.centerXAnchor.constraint(equalTo: brutePasswordButton.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: brutePasswordButton.centerYAnchor)
        ])
    }

    private func notifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.logInError), name: Notification.Name("logInError"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.logInSuccess), name: Notification.Name("logInSuccess"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.signUpError), name: Notification.Name("signUpError"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.signUpSuccess), name: Notification.Name("signUpSuccess"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.userExists), name: Notification.Name("userExists"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.userNotExists), name: Notification.Name("userNotExists"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.passwordIsWrong), name: Notification.Name("passwordIsWrong"), object: nil)
        
        isLogin = UserDefaults.standard.bool(forKey: "isLogin")
        if isLogin {
            NotificationCenter.default.post(name: Notification.Name("logInSuccess"), object: nil)
        }
    }
    
    func biometricsButton() {
        switch authService.biometryType {
        case .faceID:
            faceIDButton.setBackgroundImage(UIImage(systemName: "faceid"), for: .normal)
        case .touchID:
            faceIDButton.setBackgroundImage(UIImage(systemName: "touchid"), for: .normal)
        default:
            faceIDButton.isHidden = true
        }
    }
    
    @objc func biometricsButtonTapped(sender: UIButton!) {
        
        self.authService.authorizeIfPossible { result, error in
            if let error = error {
                let nonBiometricAlert = UIAlertController(title: error.localizedDescription,
                                                          message: NSLocalizedString("NonBiometricAlertMessage", comment: ""),
                                                          preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "OK", style: .cancel)
                nonBiometricAlert.addAction(alertAction)
                self.present(nonBiometricAlert, animated: true)
            }
            if result {
                self.logInSuccess()
            }
        }
    }
    
    @objc func logInError() {
        if let logInError = LogInViewController.logInError {
            let alertVC = UIAlertController(title: "Error".localized, message: "\(String(describing: logInError))", preferredStyle: .alert)
            let action = UIAlertAction(title: "ОК", style: .default, handler: nil)
            alertVC.addAction(action)
            self.present(alertVC, animated: true, completion: nil)
        }
    }

    @objc func logInSuccess() {
#if DEBUG
        let currentUserService = TestUserService()
#else
        let currentUserService = CurrentUserService()
#endif
        let profileVC = ProfileViewController(currentUser: currentUserService.user)
        self.navigationController?.pushViewController(profileVC, animated: true)
    }

    @objc func signUpError() {
        if let signUpError = LogInViewController.signUpError {
            let alertVC = UIAlertController(title: "Error".localized, message: "\(String(describing: signUpError))", preferredStyle: .alert)
            let action = UIAlertAction(title: "ОК", style: .default, handler: nil)
            alertVC.addAction(action)
            self.present(alertVC, animated: true, completion: nil)
        }
    }

    @objc func signUpSuccess() {
        let alertVC = UIAlertController(title: "Fine!".localized, message: "Account registered".localized, preferredStyle: .alert)
        let action = UIAlertAction(title: "ОК", style: .default, handler: nil)
        alertVC.addAction(action)
        self.present(alertVC, animated: true, completion: nil)
        self.loginTextField.text?.removeAll()
        self.passwordTextField.text?.removeAll()
    }
    
    @objc func userExists() {
        let alertVC = UIAlertController(title: "Error".localized, message: "This account already exists!".localized, preferredStyle: .alert)
        let action = UIAlertAction(title: "ОК", style: .default, handler: nil)
        alertVC.addAction(action)
        self.present(alertVC, animated: true, completion: nil)
    }
    
    @objc func userNotExists() {
        let alertVC = UIAlertController(title: "Error".localized, message: "This account does not exist!".localized, preferredStyle: .alert)
        let action = UIAlertAction(title: "ОК", style: .default, handler: nil)
        alertVC.addAction(action)
        self.present(alertVC, animated: true, completion: nil)
    }
    
    @objc func passwordIsWrong() {
        let alertVC = UIAlertController(title: "Error".localized, message: "Wrong password!".localized, preferredStyle: .alert)
        let action = UIAlertAction(title: "ОК", style: .default, handler: nil)
        alertVC.addAction(action)
        self.present(alertVC, animated: true, completion: nil)
    }
}

extension LogInViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        notificationCenter.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

extension LogInViewController {
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            scrollView.contentOffset.y = keyboardSize.height - (scrollView.frame.height - loginButton.frame.minY)
            scrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        scrollView.contentOffset = CGPoint(x: 0, y: 0)
    }

    @objc private func loginButtonPressed() {

        guard loginTextField.text?.isEmpty == false else {
            let alertVC = UIAlertController(title: "Error".localized, message: "Enter login!".localized, preferredStyle: .alert)
            let action = UIAlertAction(title: "ОК", style: .default, handler: nil)
            alertVC.addAction(action)
            self.present(alertVC, animated: true, completion: nil)
            return }

        guard passwordTextField.text?.isEmpty == false else {
            let alertVC = UIAlertController(title: "Error".localized, message: "Enter password!".localized, preferredStyle: .alert)
            let action = UIAlertAction(title: "ОК", style: .default, handler: nil)
            alertVC.addAction(action)
            self.present(alertVC, animated: true, completion: nil)
            return }

        guard let login = loginTextField.text else { return }
        guard let password = passwordTextField.text else { return }

        let checkerService = CheckerService()
        checkerService.signUp(login: login, password: password)
    }

    @objc private func signUpButtonPressed() {

        guard loginTextField.text?.isEmpty == false else {
            let alertVC = UIAlertController(title: "Error".localized, message: "Enter login!".localized, preferredStyle: .alert)
            let action = UIAlertAction(title: "ОК", style: .default, handler: nil)
            alertVC.addAction(action)
            self.present(alertVC, animated: true, completion: nil)
            return }

        guard passwordTextField.text?.isEmpty == false else {
            let alertVC = UIAlertController(title: "Error".localized, message: "Enter password!".localized, preferredStyle: .alert)
            let action = UIAlertAction(title: "ОК", style: .default, handler: nil)
            alertVC.addAction(action)
            self.present(alertVC, animated: true, completion: nil)
            return }

        guard let login = loginTextField.text else { return }
        guard let password = passwordTextField.text else { return }

        let checkerService = CheckerService()
        checkerService.checkCredentials(login: login, password: password)
    }

    @objc private func brutePasswordButtonPressed() {
        
        let passwordLengh = 4

        self.brutePasswordButton.isEnabled = false
        self.activityIndicator.startAnimating()

        DispatchQueue.global().async {

            GeneratePassword.shared.generatePass(count: passwordLengh)
            print(GeneratePassword.shared.generatedPassword)

            let passwordsArray = BruteForce.shared.generate(length: passwordLengh)
            for password in passwordsArray {
                if password == GeneratePassword.shared.generatedPassword {

                    DispatchQueue.main.async {
                        self.passwordTextField.text = password
                        self.passwordTextField.isSecureTextEntry = false
                        self.activityIndicator.stopAnimating()
                        self.activityIndicator.isHidden = true
                        self.brutePasswordButton.isEnabled = true
                    }
                    break
                }
            }
        }
    }
}

extension UIViewController {
    func hideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension UIViewController: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}

extension UIImage {
    func alpha(_ value:CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: CGPoint.zero, blendMode: .normal, alpha: value)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}
