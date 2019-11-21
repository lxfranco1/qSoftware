from kivy.app import App
from kivy.factory import Factory
from kivy.uix.boxlayout import BoxLayout
from kivy.uix.scrollview import ScrollView
from kivymd.theming import ThemeManager
import pyrebase

#Testing signed commits1
from kivymd.toast import toast
from kivymd.uix.card import MDCardPost


class MainApp(App):
    theme_cls = ThemeManager()
    theme_cls.primary_palette = 'Teal'
    title = "Party Finder"

    def build(self):
        return MainLayout()

    def show_password(self, field, button):
        """
        Called when you press the right button in the password field
        for the screen TextFields.

        instance_field: kivy.uix.textinput.TextInput;
        instance_button: kivymd.button.MDIconButton;

        """

        # Show or hide text of password, set focus field
        # and set icon of right button.
        field.password = not field.password
        field.focus = True
        button.icon = 'eye' if button.icon == 'eye-off' else 'eye-off'

        #app.theme_cls.primary_palette = "BlueGray"

class MainLayout(BoxLayout):
    def test(self):
        b = ExampleCardPost()
        screen = b.build()
        b.on_start(screen)
        return b

class ExampleCardPost(BoxLayout):
    cards_created = False

    def build(self):
        MainApp.screen = Factory.ExampleCardPost()
        return MainApp.screen

    def on_start(self, screen):

        def callback_for_menu_items(text_item):
            toast(text_item)

        def callback(instance, value):
            if value and isinstance(value, int):
                toast('Set like in %d stars' % value)
            elif value and isinstance(value, str):
                toast('Repost with %s ' % value)
            elif value and isinstance(value, list):
                toast(value[1])
            else:
                toast('Delete post %s' % str(instance))

        instance_grid_card = self.ids.grid_card
        buttons = ['facebook', 'vk', 'twitter']
        menu_items = [
            {'viewclass': 'MDMenuItem',
             'text': 'Share Post',
             'callback': callback_for_menu_items},
            {'viewclass': 'MDMenuItem',
             'text': 'Edit Post',
             'callback': callback_for_menu_items}
        ]

        if not self.cards_created:
            self.cards_created = True

            config = {
                "apiKey": "AIzaSyAhOVY1khHv6nLk5g9tmcMt6X5eIQZpk1I",
                "authDomain": "party-app-e1f63.firebaseapp.com",
                "databaseURL": "https://party-app-e1f63.firebaseio.com",
                "storageBucket": "party-app-e1f63.appspot.com",
                "serviceAccount": "party-app-e1f63-firebase-adminsdk-b6c6o-26ecb29ae3.json"
            }
            firebase = pyrebase.initialize_app(config)
            auth = firebase.auth()
            # authenticate a user
            user = auth.sign_in_with_email_and_password("thisjustin1997@gmail.com", "password")
            db = firebase.database()

            all_events = db.child('events').get(user['idToken']).val()
            keys = list(all_events.keys())

            for i in range(len(keys)):
                key = keys[i]
                instance_grid_card.add_widget(
                    MDCardPost(text_post=all_events[key]['description'],
                               name_data=all_events[key]['user'] + "\n" + all_events[key]['date'],
                               path_to_avatar='assets/defaultProfile.jpg', right_menu=menu_items,
                               swipe=True, callback=callback))


    # def __init__(self, **kwargs):
    #     super(ExampleCardPost, self).__init__(**kwargs)
    #     self.screen = Factory.ExampleCardPost()
    #     def callback_for_menu_items(text_item):
    #         toast(text_item)
    #
    #     def callback(instance, value):
    #         if value and isinstance(value, int):
    #             toast('Set like in %d stars' % value)
    #         elif value and isinstance(value, str):
    #             toast('Repost with %s ' % value)
    #         elif value and isinstance(value, list):
    #             toast(value[1])
    #         else:
    #             toast('Delete post %s' % str(instance))
    #
    #     instance_grid_card = self.screen.ids.grid_card
    #     buttons = ['facebook', 'vk', 'twitter']
    #     menu_items = [
    #         {'viewclass': 'MDMenuItem',
    #          'text': 'Share Post',
    #          'callback': callback_for_menu_items},
    #         {'viewclass': 'MDMenuItem',
    #          'text': 'Edit Post',
    #          'callback': callback_for_menu_items}
    #     ]
    #
    #     if not self.cards_created:
    #         self.cards_created = True
    #
    #         config = {
    #             "apiKey": "AIzaSyAhOVY1khHv6nLk5g9tmcMt6X5eIQZpk1I",
    #             "authDomain": "party-app-e1f63.firebaseapp.com",
    #             "databaseURL": "https://party-app-e1f63.firebaseio.com",
    #             "storageBucket": "party-app-e1f63.appspot.com",
    #             "serviceAccount": "party-app-e1f63-firebase-adminsdk-b6c6o-26ecb29ae3.json"
    #         }
    #         firebase = pyrebase.initialize_app(config)
    #         auth = firebase.auth()
    #         # authenticate a user
    #         user = auth.sign_in_with_email_and_password("thisjustin1997@gmail.com", "password")
    #         db = firebase.database()
    #
    #         all_events = db.child('events').get(user['idToken']).val()
    #         keys = list(all_events.keys())
    #
    #         for i in range(len(keys)):
    #             key = keys[i]
    #             instance_grid_card.add_widget(
    #                 MDCardPost(text_post=all_events[key]['description'],
    #                            name_data=all_events[key]['user'] + "\n" + all_events[key]['date'],
    #                            path_to_avatar='party-app/assets/defaultProfile.jpg', right_menu=menu_items,
    #                            swipe=True, callback=callback))


    # def add_cards(self):
    #
    #     def callback_for_menu_items(text_item):
    #         toast(text_item)
    #
    #     def callback(instance, value):
    #         if value and isinstance(value, int):
    #             toast('Set like in %d stars' % value)
    #         elif value and isinstance(value, str):
    #             toast('Repost with %s ' % value)
    #         elif value and isinstance(value, list):
    #             toast(value[1])
    #         else:
    #             toast('Delete post %s' % str(instance))
    #
    #     instance_grid_card = self.screen.ids.grid_card
    #     buttons = ['facebook', 'vk', 'twitter']
    #     menu_items = [
    #         {'viewclass': 'MDMenuItem',
    #          'text': 'Share Post',
    #          'callback': callback_for_menu_items},
    #         {'viewclass': 'MDMenuItem',
    #          'text': 'Edit Post',
    #          'callback': callback_for_menu_items}
    #     ]
    #
    #     if not self.cards_created:
    #         self.cards_created = True
    #
    #         config = {
    #             "apiKey": "AIzaSyAhOVY1khHv6nLk5g9tmcMt6X5eIQZpk1I",
    #             "authDomain": "party-app-e1f63.firebaseapp.com",
    #             "databaseURL": "https://party-app-e1f63.firebaseio.com",
    #             "storageBucket": "party-app-e1f63.appspot.com",
    #             "serviceAccount": "party-app-e1f63-firebase-adminsdk-b6c6o-26ecb29ae3.json"
    #         }
    #         firebase = pyrebase.initialize_app(config)
    #         auth = firebase.auth()
    #         # authenticate a user
    #         user = auth.sign_in_with_email_and_password("thisjustin1997@gmail.com", "password")
    #         db = firebase.database()
    #
    #         all_events = db.child('events').get(user['idToken']).val()
    #         keys = list(all_events.keys())
    #
    #         for i in range(len(keys)):
    #             key = keys[i]
    #             instance_grid_card.add_widget(
    #                 MDCardPost(text_post=all_events[key]['description'],
    #                            name_data=all_events[key]['user'] + "\n" + all_events[key]['date'],
    #                            path_to_avatar='party-app/assets/defaultProfile.jpg', right_menu=menu_items,
    #                            swipe=True, callback=callback))



    

MainApp().run()
