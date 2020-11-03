module ApplicationHelper
# specifically for views, doenst touch db, just for display
    def render_nav_bar
        if logged_in?
            render partial: 'partials/navbar'
        else
            render partial: 'partials/loggedout_nav'
        end
    end
end
