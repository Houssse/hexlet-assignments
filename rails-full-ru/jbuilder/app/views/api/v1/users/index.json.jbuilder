# frozen_string_literal: true

json.array!(@users) do |user|
  json.id user.id
  json.email user.email
  json.address user.address
  json.full_name "#{user.first_name} #{user.last_name}"
  json.posts user.posts do |post|
    json.partial! 'api/v1/users/posts', post: post
  end
end
