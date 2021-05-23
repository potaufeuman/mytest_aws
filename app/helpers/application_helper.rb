module ApplicationHelper
  # 国際化用
  def i18n_url_for(options)
    if options[:locale] == I18n.default_locale
      options[:locale] = nil
    end
    options = params.permit!.to_h
    url_for(options)
  end

  # ページごとの完全なタイトルを返します。
  # サブtitleがない場合、MyTest…と表示します。
  def full_title(page_title = '')
    base_title = "MyTest"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end
end
