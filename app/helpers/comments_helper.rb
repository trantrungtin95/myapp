module CommentsHelper
    def generate_comment_content(comment)
        # TODO: using recursive or while do 
        # generate comment content
        # html. It's not ruby
        #<p class='comment' id='comment-<%= comment.id %>' ><strong><%= comment.user.name %></strong> said: <%= comment.content  %>
#   - <i>created <%= time_ago_in_words(comment.created_at) %> ago</i>
#   <%= link_to 'Reply', new_product_review_comment_path(@product, comment.review, comment_id: comment.id), remote: true %>

#  </p> 
        content = content_tag(:p, class: 'comment', id: "comment-#{comment.id}") do
            tag = content_tag(:strong, comment.user.name + " said : ")
            tag += comment.content
            tag
        end
        # TODO: add level of comment (children comment for alignment)
        comment.children_comments.each do |children_comment|
            content += generate_comment_content(children_comment)
        end
        content
    end
end
