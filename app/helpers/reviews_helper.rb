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

end