module ApplicationHelper
  def gravatar_for(user, options = { size: 80, center: false })
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    center = options[:center]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"

    classes = 'img-circle img-responsive'
    classes += ' center-block' if center

    image_tag(gravatar_url, alt: user.username, class: classes)
  end
end
