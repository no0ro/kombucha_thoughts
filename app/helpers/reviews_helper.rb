module ReviewsHelper
    def display_header(review)
        if params[:kombucha_id] 
            content_tag(:h1, "Add a Review for:  #{@review.kombucha.flavor} -  #{@review.kombucha.brand.name}") 
        else 
            content_tag(:h1, "Create a review")
        end 
    end 
end


# what code looked like in the views
# def display_header 
#     <% if params[:kombucha_id] %>
#         <h1> Review for: <%= @review.kombucha.flavor %> - <%= @review.kombucha.brand.name %></h1> 
#     <% else %> 
#         <h1> Create a review </h1>
#     <% end %>
# end 