//
//  ViewController.swift
//  COBSCCOMP202P-001
//
//  Created by Amanda Wickramasekera on 2023-01-12.
//

import UIKit
import SnapKit
import FirebaseAuth

class ViewController: UIViewController {
    
    let imgView : UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()

    let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Sign in to continue"
        label.font = .systemFont(ofSize: 20, weight: .regular)
        return label
    }()
    
    let emailText: UITextField = {
        let text = UITextField()
        text.textAlignment = .center
        text.placeholder = "Email address"
        text.layer.borderWidth = 1
        text.layer.borderColor = UIColor.systemGray.cgColor
        text.autocapitalizationType = .none
        text.autocorrectionType = .no
        return text
    }()
    
    let pwText: UITextField = {
        let text = UITextField()
        text.textAlignment = .center
        text.placeholder = "Password"
        text.isSecureTextEntry = true
        text.layer.borderWidth = 1
        text.layer.borderColor = UIColor.systemGray.cgColor
        text.autocapitalizationType = .none
        text.autocorrectionType = .no
        return text
    }()
    
    let btnLogin: UIButton = {
        let btn = UIButton()
        btn.setTitleColor(.systemGreen, for: .normal)
        btn.setTitle("Sign in", for: .normal)
        return btn
    }()
    
    let btnReg: UIButton = {
        let btn = UIButton()
        btn.setTitleColor(.systemGreen, for: .normal)
        btn.setTitle("New User? Sign up", for: .normal)
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        setupUI()
        btnLogin.addTarget(self, action: #selector(signIn), for: .touchUpInside)
        
        btnReg.addTarget(self, action: #selector(openSignUp), for: .touchUpInside)
        
    }

    func setupUI()
    {
        self.imgView.image = UIImage(named: "foodimg")
        self.imgView.contentMode = .top
        
        let viewHolder = UIStackView(arrangedSubviews: [label, emailText, pwText, btnLogin, btnReg])
        viewHolder.axis = .vertical
        viewHolder.spacing = 30
        
        self.view.addSubview(imgView)
        self.view.addSubview(viewHolder)
        
        imgView.snp.makeConstraints{make in
            make.top.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        viewHolder.snp.makeConstraints{make in
            make.top.equalTo(imgView.snp_bottomMargin).offset(30)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        emailText.becomeFirstResponder()
    }
    
    @objc private func signIn()
    {
        
        guard let email = emailText.text, !email.isEmpty,
              let pw = pwText.text, !pw.isEmpty
        else{
            let alert = UIAlertController(title: "Credentials not entered", message: "Please enter credentials and try again", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {_ in}))
            self.present(alert, animated: true)
            return
        }
        
        
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: pw, completion: {result, error in
            if error != nil{
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: {_ in}))
                self.present(alert, animated: true)
                return
            } else{
                let vc = BookmarksViewController()
                self.present(vc, animated: true, completion: nil)
            }
        })
    }

    @objc func openSignUp()
    {
        let vc = SignUpViewController()
        self.present(vc, animated: true, completion: nil)
        //self.navigationController?.pushViewController(vc, animated: true)
    }
}



