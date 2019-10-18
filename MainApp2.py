from kivy.app import App
from kivy.uix.tabbedpanel import TabbedPanel
from kivy.uix.boxlayout import BoxLayout
from kivy.properties import ObjectProperty
from kivy.lang import Builder
from kivy.uix.gridlayout import GridLayout
from kivy.uix.button import Button
from kivy.uix.scrollview import ScrollView
from kivy.core.window import Window
from kivy.app import runTouchApp

Builder.load_string('''

<CustomWidthTabb@TabbedPanelItem>
    width: self.texture_size[0]
    padding: 10, 0
    size_hint_x: None
    
<RootWidget>:
    carousel: carousel
    do_default_tab: False
    orientation: "vertical"
    tab_pos: 'top_mid' #the tab orientation
    tab_height: 40
    tab_width: 250
        
    Carousel:
        on_index: root.on_index(*args)
        id: carousel
        Button:
            text: 'Slide One Information'
            tab: tab1
            
        Button:
            text: 'Slide Two Information'
            tab:tab2
        Button:
            text: 'Slide Three Information'
            tab: tab3


    CustomWidthTabb:
        id: tab1
        text: 'Home'
        slide: 0
    CustomWidthTabb:
        id: tab2
        text: 'Trending'
        slide: 1
    CustomWidthTabb:
        id: tab3
        text: 'Nearby'
        slide: 2


''')

class RootWidget(TabbedPanel):

    def on_index(self, instance, value):
        tab = instance.current_slide.tab
        if self.current_tab != tab:
            self.switch_to(tab)

    def switch_to(self, header):
        # we have to replace the functionality of the original switch_to
        self.current_tab.state = "normal"
        header.state = 'down'
        self._current_tab = header
        # set the carousel to load  the appropriate slide
        # saved in the screen attribute of the tab head
        self.carousel.index = header.slide


class MainApp(App):

    def build(self):
        return RootWidget()


if __name__ == '__main__':
    MainApp().run()
