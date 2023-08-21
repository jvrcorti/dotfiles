from libqtile import widget
from .theme import colors

# Get the icons at https://www.nerdfonts.com/cheat-sheet (you need a Nerd Font)

def base(fg='text', bg='dark'): 
    return {
        'foreground': colors[fg],
        'background': colors[bg]
    }


def separator():
    return widget.Sep(**base(), linewidth=0, padding=0)


def icon(fg='text', bg='dark', fontsize=16, text="?"):
    return widget.TextBox(
        **base(fg, bg),
        fontsize=fontsize,
        text=text,
        padding=2
    )


def powerline(fg="light", bg="dark"):
    return widget.TextBox(
        **base(fg, bg),
        text="", # Icon: nf-oct-triangle_left
        fontsize=37,
        padding=-3
    )


def workspaces(): 
    return [
        separator(),
        widget.GroupBox(
            **base(fg='light'),
            font='UbuntuMono Nerd Font',
            fontsize=19,
            margin_y=3,
            margin_x=0,
            padding_y=8,
            padding_x=5,
            borderwidth=0,
            active=colors['active'],
            inactive=colors['inactive'],
            rounded=True,
            highlight_method='text',
            urgent_alert_method='block',
            urgent_border=colors['urgent'],
            this_current_screen_border=colors['focus'],
            this_screen_border=colors['grey'],
            other_current_screen_border=colors['dark'],
            other_screen_border=colors['dark'],
            disable_drag=True
        ),
        separator(),
        widget.WindowName(**base(fg='focus'), fontsize=14, padding=5),
        separator(),
    ]


primary_widgets = [
    *workspaces(),

    separator(),

    powerline('color4', 'dark'),

    icon(bg="color4", text=' '), # Icon: nf-fa-download
    
    widget.CheckUpdates(
            background=colors['color4'],
            colour_have_updates=colors['text'],
            colour_no_updates=colors['text'],
            no_update_string='0',
            display_format='{updates}',
            update_interval=1800,
            custom_command='checkupdates',
        ),

    powerline('color3', 'color4'),

    icon(bg="color3", text=' '),  # Icon: nf-fa-feed
    
    widget.NetGraph(**base(bg='color3'), 
            interface='auto', 
            type='line', 
            graph_color='deff00',
        ),
        #widget.Net(**base(bg='color3'), interface='enp0s3'),

    powerline('color2', 'color3'),

    widget.CurrentLayoutIcon(**base(bg='color2'), scale=0.75),

    widget.CurrentLayout(**base(bg='color2'), padding=5),

    powerline('color1', 'color2'),

    icon(bg="color1", fontsize=19, text=' '), 

    widget.Clock(**base(bg='color1'), format='%d/%m/%Y  %H:%M '),

    powerline('color5', 'color1'),

	icon(bg="color5", fontsize=19, text=''),	

	widget.Battery(**base(bg='color5'), 
            fontsize=19,
			charge_char='', 
            discharge_char='', 
            empty_char='', 
            unknown_char='',  
            format='{char} {percent:2.0%} {hour:d} {watt:.1f}W',
        ),

    powerline('color7', 'color5'),
    
    icon(bg="color7", fontsize=19,  text='墳 '),	
    
    widget.Volume(**base(bg='color7'), limit_max_volume='true'),

    powerline('grey', 'color7'),   

	widget.Systray(background=colors['grey'], padding=3),
]

secondary_widgets = [
    *workspaces(),

    separator(),
    
    powerline('color4', 'dark'),
    
    icon(bg='color4', fontsize=19, text=' '),
    
    widget.ThermalZone(**base(bg='color4'), format='{themp}°C'),
    
    powerline('color3', 'color4'),
    
    icon(bg='color3', fontsize=19, text=' '),
    
    widget.Memory(**base(bg='color3'), measure_mem='G'),

    powerline('color1', 'color3'),

    widget.CurrentLayoutIcon(**base(bg='color1'), scale=0.65),

    widget.CurrentLayout(**base(bg='color1'), padding=5),

    powerline('color2', 'color1'),

    widget.Clock(**base(bg='color2'), format='%d/%m/%Y - %H:%M '),
    
    powerline('dark', 'color2'),
]

widget_defaults = {
    'font': 'UbuntuMono Nerd Font Bold',
    'fontsize': 14,
    'padding': 1,
}
extension_defaults = widget_defaults.copy()
