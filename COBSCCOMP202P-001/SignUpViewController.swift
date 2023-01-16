//
//  SignUpViewController.swift
//  COBSCCOMP202P-001
//
//  Created by Amanda Wickramasekera on 2023-01-13.
//

import UIKit
import SnapKit
import FirebaseAuth
import FirebaseDatabase

class SignUpViewController: UIViewController {

    let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Sign up to continue"
        label.font = .systemFont(ofSize: 20, weight: .regular)
        return label
    }()
    
    let nameText: UITextField = {
        let text = UITextField()
        text.textAlignment = .center
        text.placeholder = "Name"
        text.layer.borderWidth = 1
        text.layer.borderColor = UIColor.systemGray.cgColor
        return text
    }()
    
    let emailText: UITextField = {
        let text = UITextField()
        text.textAlignment = .center
        text.placeholder = "Email address"
        text.layer.borderWidth = 1
        text.layer.borderColor = UIColor.systemGray.cgColor
        return text
    }()
    
    let pwText: UITextField = {
        let text = UITextField()
        text.textAlignment = .center
        text.placeholder = "Password"
        text.isSecureTextEntry = true
        text.layer.borderWidth = 1
        text.layer.borderColor = UIColor.systemGray.cgColor
        return text
    }()
    
    
    let cpwText: UITextField = {
        let text = UITextField()
        text.textAlignment = .center
        text.placeholder = "Confirm password"
        text.isSecureTextEntry = true
        text.layer.borderWidth = 1
        text.layer.borderColor = UIColor.systemGray.cgColor
        return text
    }()
    
    
    let btnRegister: UIButton = {
        let btn = UIButton()
        btn.setTitleColor(.systemGreen, for: .normal)
        btn.setTitle("Sign up", for: .normal)
        return btn
    }()

    let btnLog: UIButton = {
        let btn = UIButton()
        btn.setTitleColor(.systemGreen, for: .normal)
        btn.setTitle("Already have an account? Sign in", for: .normal)
        return btn
    }()
    
    let database = Database.database().reference()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        setupUI()
        btnRegister.addTarget(self, action: #selector(signUp), for: .touchUpInside)
        
        btnLog.addTarget(self, action: #selector(openSignIn), for: .touchUpInside)
    }

    func setupUI()
    {
    
        nameText.frame = CGRect(x: 20, y: 60, width: 50, height: 50)
        emailText.frame = CGRect(x: 20, y: 120, width: 50, height: 50)
        pwText.frame = CGRect(x: 20, y: 180, width: 50, height: 50)
        cpwText.frame = CGRect(x: 20, y: 240, width: 50, height: 50)
        let viewHolder = UIStackView(arrangedSubviews: [label, nameText, emailText, pwText, btnRegister, btnLog])
        viewHolder.axis = .vertical
        viewHolder.spacing = 15
        
        self.view.addSubview(viewHolder)
        
        viewHolder.snp.makeConstraints{make in make.top.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        nameText.becomeFirstResponder()
    }
    
    @objc private func signUp()
    {
        guard let name = nameText.text, !name.isEmpty,
              let email = emailText.text, !email.isEmpty,
              let pw = pwText.text, !pw.isEmpty,
              let cpw = cpwText.text, !cpw.isEmpty
        else{
            let alert = UIAlertController(title: "Details not entered", message: "Please enter your details and try again", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {_ in}))
            self.present(alert, animated: true)
            return
        }
        
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: pw, completion: {result, error in
            guard error == nil else{
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: {_ in}))
                self.present(alert, animated: true)
                return
            }
            
            let user = FirebaseAuth.Auth.auth().currentUser
            if(user != nil)
            {
                let userkey = user!.uid
                let object: [String: Any] = [
                    "uid": userkey,
                    "name": name
                    //"favourites": ""
                ]
                self.database.child("Users").child(userkey).setValue(object)
            }
        })
        
        
    
    }
    
    @objc private func openSignIn()
    {
        let vc = ViewController()
        self.present(vc, animated: true, completion: nil)
    }
}
