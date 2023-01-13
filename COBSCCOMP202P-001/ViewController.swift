//
//  ViewController.swift
//  COBSCCOMP202P-001
//
//  Created by Amanda Wickramasekera on 2023-01-12.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

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
        
    }

    func setupUI()
    {
        let viewHolder = UIStackView(arrangedSubviews: [label, emailText, pwText, btnLogin, btnReg])
        viewHolder.axis = .vertical
        viewHolder.spacing = 15
        
        self.view.addSubview(viewHolder)
        
        viewHolder.snp.makeConstraints{make in make.top.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
    }
    
    func signIn()
    {
        
    }

}



