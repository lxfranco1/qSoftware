from kivy.app import App
# from database import DataBase
from kivy.lang import Builder
from kivy.uix.popup import Popup
from kivy.uix.label import Label
from kivy.uix.image import Image
from kivy.properties import ObjectProperty
from kivy.uix.floatlayout import FloatLayout
from kivy.core.image import Image as CoreImage
from kivy.uix.screenmanager import ScreenManager, Screen
import pyrebase
config = {
    "apiKey": "AIzaSyDOdhV68Ia82s51ZP-RyBHYyT4r6E1XxdI",
    "authDomain": "partyfinder-fdfc5.firebaseapp.com",
    "databaseURL": "https://partyfinder-fdfc5.firebaseio.com",
    "projectId": "partyfinder-fdfc5",
    "storageBucket": "partyfinder-fdfc5.appspot.com",
    "messagingSenderId": "1010182275180",
    "appId": "1:1010182275180:web:4f5e2ad900d95cc7fa9849",
    "measurementId": "G-FDJR3YJCCY"

}

# For firebase
firebase = pyrebase.initialize_app(config)
auth = firebase.auth()

class NewsFeed(Screen):
    def logOut(self):
        sm.current = "login"

class CreateAccountWindow(Screen):

    # To upload background image
    def build(self):
        self.Fond=FloatLayout()
        self.Imgl=Image(source='backgroundImage.png', allow_stretch=True, keep_ratio=False)
        self.Fond.add_widget(self.Imgl)

    namee = ObjectProperty(None)
    email = ObjectProperty(None)
    password = ObjectProperty(None)

    # Submit button after user has created an account
    def submit(self):
        if self.namee.text != "" and self.email.text != "" and self.email.text.count("@") == 1 and self.email.text.count(".") > 0:
            if self.password != "":
                try:  # Checks for valid username and password
                    auth.create_user_with_email_and_password(self.email.text, self.password.text)
                    self.resetAll()
                    sm.current = "login"
# TODO: popup that account was created successfully
# TODO: add exception condition
                except:
                    sm.current = "create"
                    self.resetAll()
                    return invalidForm()
            else:
                invalidForm()
        else:
            invalidForm()

    def login(self):
        self.reset()
        sm.current = "login"

# TODO: if only password is invalid, remove the password text. If Email is invalid, remove both password and email field
    def reset(self):    # Reset 
        self.email.text = ""
        self.namee.text = ""

    def resetAll(self):
        self.email.text = ""
        self.password.text = ""
        self.namee.text = ""

class LoginWindow(Screen):

    email = ObjectProperty(None)
    password = ObjectProperty(None)

    def loginBtn(self):
        try:
            auth.sign_in_with_email_and_password(self.email.text, self.password.text)
            self.reset()
            sm.current = "feed"

# TODO: add exception condition
        except:
            return invalidLogin()

    def createBtn(self):
        self.reset()
        sm.current = "create"

    def reset(self):
        self.email.text = ""
        self.password.text = ""


class MainWindow(Screen):
    n = ObjectProperty(None)
    created = ObjectProperty(None)
    email = ObjectProperty(None)
    current = ""

    def logOut(self):
        sm.current = "login"


class WindowManager(ScreenManager):
    pass


def invalidLogin():
    pop = Popup(title='Invalid Login',
                  content=Label(text='Invalid username or password.'),
                  size_hint=(None, None), size=(400, 400))
    pop.open()

def invalidForm():
    pop = Popup(title='Invalid Form',
                  content=Label(text='Please fill in all inputs with valid information.'),
                  size_hint=(None, None), size=(400, 400))

    pop.open()


kv = Builder.load_file("login.kv")

sm = WindowManager()

screens = [LoginWindow(name="login"), CreateAccountWindow(name="create"), MainWindow(name="main"), NewsFeed(name="feed")]
for screen in screens:
    sm.add_widget(screen)

sm.current = "login"


class MyMainApp(App):
    def build(self):
        return sm


if __name__ == "__main__":
    MyMainApp().run()