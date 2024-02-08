class CommentSerializer
  include JSONAPI::Serializer

  set_key_transform :camel_lower

  attributes :id, :message

  attributes :votes_count

  attributes :votes

  attributes :user do |post|
    {
      id: post.user.id,
      name: post.user.name
    }
  end

  attributes :replies do |comment| comment.comments end
  attributes :created_at
end