module KombuchasHelper

    def edit_kombucha_if_creator
        if logged_in? && @kombucha.user_id == current_user.id
            content_tag(:h6, (link_to 'Edit Kombucha', edit_kombucha_path(@kombucha)), {class: "card-subtitle mb-2 shiftp text-muted small"} )
        end
    end
end
