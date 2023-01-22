//
//  ViewController.swift
//  COBSCCOMP202P-001
//
//  Created by Amanda Wickramasekera on 2023-01-12.
//

import UIKit //this line imports UIKit with which we create UI components
import SnapKit //this line imports SnapKit with which we create constraints
import FirebaseAuth //this line imports Firebase Auth which we use to register and login users

class ViewController: UIViewController {
    
    
    //creating the imageView which is added just to make the UI look better
    let imgView : UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()

    //creating the label which displays the text 'Sign in to continue'
    let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center //this line aligns the label to center
        label.text = "Sign in to continue" //this line sets the text displayed in the label
        label.font = .systemFont(ofSize: 20, weight: .regular) //this line sets the font size and font weight
        return label
    }()
    
    
    //creating the text field where user enters email address
    let emailText: UITextField = {
        let text = UITextField()
        text.textAlignment = .center //this line aligns the text field to center
        text.placeholder = "Email address" //this line adds the hint that the user should enter email address in this textfield
        text.layer.borderWidth = 1 //this line sets the border width of the text field to 1
        text.layer.borderColor = UIColor.systemGray.cgColor //this line sets the border color of the text field to gray
        text.autocapitalizationType = .none //this line disables autocapitalization for this text field
        text.autocorrectionType = .no //this line disables autocorrection for this text field
        return text
    }()
    
    
    //creating the text field where user enters password
    let pwText: UITextField = {
        let text = UITextField()
        text.textAlignment = .center //this line aligns the text field to center
        text.placeholder = "Password" //this line adds the hint that the user should enter password in this textfield
        text.isSecureTextEntry = true //this line hides the password that is entered to this text field with dots
        text.layer.borderWidth = 1 //this line sets the border width of the text field to 1
        text.layer.borderColor = UIColor.systemGray.cgColor //this line sets the border color of the text field to gray
        text.autocapitalizationType = .none //this line disables autocapitalization for this text field
        text.autocorrectionType = .no //this line disables autocorrection for this text field
        return text
    }()
    
    
    //creating the login button which allows user to log in
    let btnLogin: UIButton = {
        let btn = UIButton()
        btn.setTitleColor(.white, for: .normal) //this line sets the color of the button text to white
        btn.backgroundColor = .systemGreen //this line sets the color of the button background to systemGreen
        btn.setTitle("Sign in", for: .normal) //this line sets the text that the button should display
        return btn
    }()
    
    
    //creating the register button which redirects the new users to register screen
    let btnReg: UIButton = {
        let btn = UIButton()
        btn.setTitleColor(.white, for: .normal) //this line sets the color of the button text to white
        btn.backgroundColor = .systemGreen //this line sets the color of the button background to systemGreen
        btn.setTitle("New User? Sign up", for: .normal) //this line sets the text that the button should display
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white //this line makes the screen white in color
        setupUI() //calling setupUI function
        
        btnLogin.addTarget(self, action: #selector(signIn), for: .touchUpInside) //this line calls the signIn function whenever user clicks on btnLogin
        
        btnReg.addTarget(self, action: #selector(openSignUp), for: .touchUpInside) //this line calls the openSignUp function whenever user clicks on btnReg
        
    }

    //declaring setupUI function
    func setupUI()
    {
        self.imgView.image = UIImage(named: "food") //this line adds the image named 'food' in assets into the imageView
        
        self.imgView.contentMode = .top
        
        let viewHolder = UIStackView(arrangedSubviews: [label, emailText, pwText, btnLogin, btnReg]) //this line adds the subviews into the viewholder
        viewHolder.axis = .vertical //this line sets viewholder's axis to vertical (this means the subviews of the viewholder are set one after the other vertically)
        viewHolder.spacing = 20 //this line sets a space between the subviews of the viewholder
        
        self.view.addSubview(imgView) //this line adds imgView to the main screen
        self.view.addSubview(viewHolder) //this line adds the viewHolder to the main screen
        
        
        //the following part of code creates constrains for imgView with SnapKit
        imgView.snp.makeConstraints{make in
            make.top.equalToSuperview().offset(75)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        //the following part of code creates constrains for viewHolder with SnapKit
        viewHolder.snp.makeConstraints{make in
            make.top.equalTo(imgView.snp_bottomMargin).offset(30)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        emailText.becomeFirstResponder() //this sets the curser to the emailText text field when the screen appears
    }
    
    
    //declaring signIn function
    @objc private func signIn()
    {
        //following part of code checks if the user has entered credentials and if not an alert is displayed to the user
        guard let email = emailText.text, !email.isEmpty,
              let pw = pwText.text, !pw.isEmpty
        else{
            let alert = UIAlertController(title: "Credentials not entered", message: "Please enter credentials and try again", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {_ in}))
            self.present(alert, animated: true)
            return
        }
        
        //following part of code logs the user in and redirects the user to home screen if there is no error in logging in. If there is an error in logging in an alert will be displayed to the user
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: pw, completion: {result, error in
            if error != nil{
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: {_ in}))
                self.present(alert, animated: true)
                return
            } else{
                
                self.navigationController?.pushViewController(HomeViewController(), animated: false)
                
            }
        })
    }

    //declaring openSignUp function
    @objc func openSignUp()
    {
        //the following lines of code opens the SignUpViewController where the new users can register
        navigationController?.pushViewController(SignUpViewController(), animated: false)
        
    }
}



