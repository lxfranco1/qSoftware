'''
TabbedPanel
============

Test of the widget TabbedPanel.
'''

from kivy.app import App
from kivy.uix.tabbedpanel import TabbedPanel
from kivy.lang import Builder
Builder.load_string("""

<Test>:

    size_hint: .5, .5
    pos_hint: {'center_x': .5, 'center_y': .5}
    do_default_tab: False

    TabbedPanelItem:
        text: 'Profile'
       # background_color: 1,1,1,1
        Label:
            text: 'Profile Information'
    TabbedPanelItem:
        text: 'Following'
       # background_color: 1,1,1,1
        BoxLayout:
            Label:
                text: 'Second tab content area'
            Button:
                text: 'Button that does nothing'
    TabbedPanelItem:
        text: 'Listings'
        #background_color: 1,1,1,1
        RstDocument:
            text:
                '\\n'.join(("This is an example", "-----------",
                "You are in the third tab."))


<TabbedPanelStrip>
    canvas:
        Color:
            rgba: (0, 1, 0, 1) # green
        Rectangle:
            size: self.size
            pos: self.pos
""")


class Test(TabbedPanel):

    pass


class TabbedPanelApp(App):

    def build(self):

        return Test()


if __name__ == '__main__':
    TabbedPanelApp().run()