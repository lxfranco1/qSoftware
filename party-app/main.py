from kivy.app import App
from kivymd.theming import ThemeManager

#Testing signed commits1
class MainApp(App):
    theme_cls = ThemeManager()

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
    

MainApp().run()
