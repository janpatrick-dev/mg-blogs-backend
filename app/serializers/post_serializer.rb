class PostSerializer
  include JSONAPI::Serializer

  set_key_transform :camel_lower

  attributes :id, :title, :body, :votes, :tags

  attribute :formatted_created_at do |record|
    record.created_at.strftime("%B %d %Y")
  end
end