class AnnouncementSerializer < ActiveModel::Serializer
  attributes :id, :text, :exp_date, :user_id, :user_name
  
  def exp_date
    object.expiration_date.to_s(:long)
  end
  
  def user_name
    User.find(object.user_id).name
  end
  
end
