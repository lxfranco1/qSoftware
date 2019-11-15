# Download the helper library from https://www.twilio.com/docs/python/install
from twilio.rest import Client


from kivy.uix.textinput import TextInput
from kivy.uix.button import Button
from kivy.uix.label import Label
from kivy.uix.gridlayout import GridLayout

from kivy.app import App


class Search(GridLayout):
  def __init__(self, **var_args):
    super(Search, self).__init__(**var_args)
    # super function can be used to gain access
    # to inherited methods from a parent or sibling class
    # that has been overwritten in a class object.
    self.cols = 2  # You can change it accordingly
    self.add_widget(Label(text='Test'))
    self.username = TextInput(multiline=True)

    # multiline is used to take
    # multiline input if it is true
    self.add_widget(self.username)
    self.add_widget(Label(text='Test'))
    self.password = TextInput(password=True, multiline=False)
    self.add_widget(self.password)
    # password true is used to hide it
    # by * self.add_widget(self.password)
    self.add_widget(Label(text='Test'))
    self.password = TextInput(password=True, multiline=False)
    self.add_widget(self.password)
    self.password.bind(on_text_validate=on_enter)

class Moderator(GridLayout):
  def __init__(self, **var_args):
    super(Moderator, self).__init__(**var_args)
    # super function can be used to gain access
    # to inherited methods from a parent or sibling class
    # that has been overwritten in a class object.
    self.cols = 2  # You can change it accordingly
    self.add_widget(Label(text='User Name'))
    self.username = TextInput(multiline=True)


    self.add_widget(self.username)
    self.add_widget(Label(text='password'))
    self.password = TextInput(password=True, multiline=False)
    self.add_widget(self.password)
    # password true is used to hide it
    # by * self.add_widget(self.password)
    self.add_widget(Label(text='Comfirm password'))
    self.password = TextInput(password=True, multiline=False)
    self.add_widget(self.password)
    self.password.bind(on_text_validate=on_enter)
def on_enter(instance):
    print('works')
    return Search()
class MyApp(App):


  def build(self):
    return Moderator()


MyApp().run()

