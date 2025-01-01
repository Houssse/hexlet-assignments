# frozen_string_literal: true

class PostPolicy < ApplicationPolicy
  # BEGIN
  attr_reader :user, :post

  def initialize(user, post)
    @user = user
    @post = post
  end

  def index?
    true
  end

  def show?
    true
  end

  def create?
    user.present?
  end

  def update?
    user.present? && (post.author == user || user.admin?)
  end

  def destroy?
    user.present? && user.admin?
  end
  # END
end
