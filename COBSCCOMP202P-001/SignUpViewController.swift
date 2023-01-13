//
//  SignUpViewController.swift
//  COBSCCOMP202P-001
//
//  Created by Amanda Wickramasekera on 2023-01-13.
//

import UIKit
import SnapKit

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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        setupUI()
        
    }

    func setupUI()
    {
        let viewHolder = UIStackView(arrangedSubviews: [label, nameText, emailText, pwText, btnRegister, btnLog])
        viewHolder.axis = .vertical
        viewHolder.spacing = 15
        
        self.view.addSubview(viewHolder)
        
        viewHolder.snp.makeConstraints{make in make.top.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
    }
    
    func signUP()
    {
        
    }

}
