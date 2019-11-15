from kivy.app import App
from kivy.lang import Builder
from kivy.factory import Factory

from kivymd.uix.card import MDCardPost
from kivymd.theming import ThemeManager
from kivymd.toast import toast
import pyrebase

Builder.load_string("""
<ExampleCardPost@BoxLayout>:
    orientation: 'vertical'
    spacing: dp(5)

    MDToolbar:
        id: toolbar
        title: app.title
        left_action_items: [['menu', lambda x: None]]
        elevation: 10
        md_bg_color: app.theme_cls.primary_color


    ScrollView:
        id: scroll
        size_hint: 1, 1
        do_scroll_x: False

        GridLayout:
            id: grid_card
            cols: 1
            spacing: dp(5)
            padding: dp(5)
            size_hint_y: None
            height: self.minimum_height
""")


class Example(App):
    theme_cls = ThemeManager()
    theme_cls.primary_palette = 'Teal'
    title = "Card Post"
    cards_created = False

    def build(self):
        self.screen = Factory.ExampleCardPost()
        return self.screen

    def on_start(self):
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

        instance_grid_card = self.screen.ids.grid_card
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
                    MDCardPost(text_post=all_events[key]['description'], name_data = all_events[key]['user'] + "\n" + all_events[key]['date'],
                               path_to_avatar = 'party-app/assets/defaultProfile.jpg', right_menu = menu_items,
                               swipe=True, callback=callback))


            # instance_grid_card.add_widget(
            #     MDCardPost(text_post='Card with text',
            #                swipe=True, callback=callback))
            # instance_grid_card.add_widget(
            #     MDCardPost(
            #         right_menu=menu_items, swipe=True,
            #         text_post='Card with a button to open the menu MDDropDown',
            #         callback=callback))
            # instance_grid_card.add_widget(
            #     MDCardPost(
            #         likes_stars=True, callback=callback, swipe=True,
            #         text_post='Card with asterisks for voting.'))
            #
            # instance_grid_card.add_widget(
            #     MDCardPost(
            #         source="./assets/kitten-1049129_1280.jpg",
            #         tile_text="Little Baby",
            #         tile_font_style="H5",
            #         text_post="This is my favorite cat. He's only six months "
            #                   "old. He loves milk and steals sausages :) "
            #                   "And he likes to play in the garden.",
            #         with_image=True, swipe=True, callback=callback,
            #         buttons=buttons))


if __name__ == "__main__":
    Example().run()