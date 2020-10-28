module ReviewsHelper
    def display_header(review)
        # in views/reviews/edit.html.erb
        if params[:kombucha_id] 
            content_tag(:h1, "Add a Review for:  #{@review.kombucha.flavor} -  #{@review.kombucha.brand.name}") 
        else 
            content_tag(:h1, "Create a review")
        end 
    end 


    def reviewed_by(review)
        # in views/reviews/show .....(later index)
        content_tag(:p, "Review by: #{@review.user.username} on #{@review.date_formatted}")
    end 
        # returns: "Review by: UserName on 1-21-2020"


end


# what code looked like in the views
# def display_header 
#     <% if params[:kombucha_id] %>
#         <h1> Review for: <%= @review.kombucha.flavor %> - <%= @review.kombucha.brand.name %></h1> 
#     <% else %> 
#         <h1> Create a review </h1>
#     <% end %>
# end 