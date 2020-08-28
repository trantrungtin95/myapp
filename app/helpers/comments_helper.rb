module CommentsHelper
    def generate_comment_content(comment)
        # TODO: using recursive or while do 
        # generate comment content
        # html. It's not ruby
        #<p class='comment' id='comment-<%= comment.id %>' ><strong><%= comment.user.name %></strong> said: <%= comment.content  %>
#   - <i>created <%= time_ago_in_words(comment.created_at) %> ago</i>
#   <%= link_to 'Reply', new_product_review_comment_path(@product, comment.review, comment_id: comment.id), remote: true %>

#  </p> 
    product = comment.review.product
        padding_left = 20 * comment.level
        content = content_tag(:p, style: "padding-left: #{padding_left}px", class: 'comment', id: "comment-#{comment.id}") do
            
            tag = content_tag(:span)
            if comment.user.avatar.present?
                tag += link_to image_tag(comment.user.avatar, class: "avatar-comment-img"), user_path(comment.user)
            end

            tag += content_tag(:strong) do
                t = link_to comment.user.name, user_path(comment.user)
            end
                
                
            tag += content_tag(:strong, " said: ")
            tag += comment.content
            tag +=" - "
            tag += content_tag(:i,"created " + time_ago_in_words(comment.created_at) + " ago")
            tag += link_to ' Reply', Rails.application.routes.url_helpers.new_product_review_comment_path(product, comment.review, comment_id: comment.id), remote: true
             # tag += link_to ' Delete', Rails.application.routes.url_helpers.product_review_comment_path(product, comment.review, comment_id: comment.id),method: :delete, remote: true
            
        end
    
        # TODO: add level of comment (children comment for alignment)
        # add list comment div for add new comment
        children = ""
        comment.children_comments.each do |children_comment|
            children += generate_comment_content(children_comment)
        end
        

        content += content_tag(:div, id: "children-comment-#{comment.id}") do
            raw children
        end
    end 

end
