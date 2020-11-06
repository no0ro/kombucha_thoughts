module ReviewsHelper

    def display_header(review) # in views/reviews/_form.html.erb
        if params[:kombucha_id] 
            content_tag(:h1, "Write a Review for:  #{@review.kombucha.flavor} -  #{@review.kombucha.brand.name}", {class: "shiftH3  text-center"}) 
        else 
            content_tag(:h1, "Write A Review", {class: "shiftH1 text-center"})
        end 
    end

end