
module RoutingHelper
  def path_to(page_name)
    case page_name
    when 'the root path', 'the homepage'
      '/'
    when 'setting page'
      '/event/init'
    when 'the event page'
      '/event/hogehoge'
    else
      raise "Can't mapping from #{page_name} to certain path"
    end
  end
end

World(RoutingHelper)

