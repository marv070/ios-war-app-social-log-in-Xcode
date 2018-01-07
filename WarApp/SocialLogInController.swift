import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn
import FBSDKLoginKit

class SocialLogInController: UIViewController, GIDSignInDelegate, GIDSignInUIDelegate, FBSDKLoginButtonDelegate {
    var name = String()
    var logout = String()
    
   
    @IBOutlet weak var faceBookLogInButton: FBSDKLoginButton!
    
   
    override func viewDidLoad() {
        if logout == "true" {
            try! Auth.auth().signOut()
            FBSDKLoginManager().logOut()
            GIDSignIn.sharedInstance().signOut()
        }
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        print(GIDSignIn.sharedInstance().clientID, "id is here!!!!!!!!")
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        faceBookLogInButton.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print(error.localizedDescription)
            return
        
        }
        let authentication = user.authentication
        let credential = GoogleAuthProvider.credential(withIDToken: (authentication?.idToken)!, accessToken: (authentication?.accessToken)!)
        Auth.auth().signIn(with: credential, completion: { (user,error) in
            if error != nil {
                print(error?.localizedDescription)
                return
            }
            self.name = (user?.displayName)!
            print("your name is \(self.name)!!!!!!!!")
            print("User loggin in with google")
            self.performSegue(withIdentifier: "ShowGameView", sender: self)
        })
    }
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print(error.localizedDescription)
            return
            
        }
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if (FBSDKAccessToken.current() == nil) {
//            print(error!.localizedDescription)
            return
        }
        let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
        Auth.auth().signIn(with: credential, completion: { (user,error) in
            if error != nil {
                print(error!.localizedDescription)
                return
            }
             self.name = (user?.displayName)!
             self.performSegue(withIdentifier: "ShowGameView", sender: self)
            print("User has signed in with Facebook!")
        })
    }
    func loginButtonWillLogin(_ loginButton: FBSDKLoginButton!) -> Bool {
        return true
    }
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        try! Auth.auth().signOut()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is ViewController {
            let nextcontroller = (segue.destination as! ViewController)
            nextcontroller.username = self.name
        }
    }
    
}





















