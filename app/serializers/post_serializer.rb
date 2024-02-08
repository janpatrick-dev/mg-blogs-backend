class PostSerializer
  include JSONAPI::Serializer

  set_key_transform :camel_lower

  attributes :id, :title, :body, :tags

  attributes :comments_count do |post| post.comments.length end

  attributes :votes_count

  attributes :votes

  attributes :user do |post|
    {
      id: post.user.id,
      name: post.user.name
    }
  end

  attributes :created_at

  attributes :is_draft
end