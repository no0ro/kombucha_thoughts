module ReviewsHelper

     # in views/reviews/_form.html.erb
    def display_header(review)
        if params[:kombucha_id] # new nested
            # hits /kombucha/1/reviews/new 
            content_tag(:h1, "Write a Review for:  #{@review.kombucha.flavor} -  #{@review.kombucha.brand.name}", {class: "shiftH3  text-center"}) 
        elsif  @review.id # edit
            # hits /reviews/1/edit   
            content_tag(:h1, "Edit Your Review For:  #{@review.kombucha.flavor} -  #{@review.kombucha.brand.name}", {class: "shiftH3  text-center"}) 
        else # new
            # /reviews/new
            content_tag(:h1, "Write A Review", {class: "shiftH1 text-center"})
        end 
    end

    def edit_review_if_creator
        if logged_in? && @review.user_id == current_user.id
            content_tag(:h6, (link_to "Edit Review", edit_review_path(@review)), {class: "card-subtitle mb-2 shiftp text-muted small"}) 
        end 
    end

    def delete_review_if_creator
        if logged_in? && @review.user_id == current_user.id
            content_tag(:h6, (button_to "Delete This Review", review_path(@review), method: :delete), {class: "card-subtitle mb-2 shiftp text-muted small"})
        end 
    end
end