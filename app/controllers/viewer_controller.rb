class ViewerController < ApplicationController

  def show

    
    if logged_in? or Parameter.find_by_name('Adgang').value == "Åben"
      
      @page = Page.find(params[:id])

      @content = @page.body rescue 'Indhold følger snarest'
      @title = @page.title rescue 'Indhold følger snarest'

      archive_count
      session[:menu_id] = params[:id]

      render :action => "show"
      
    else
      
      redirect_to root_url

    end

  end

  def forside
    @access = Parameter.find_by_name('Adgang').value
    @whereabouts = Parameter.find_by_name('Whereabouts').value

    render :layout => "startup_page"

  end


  def blog
    
    if logged_in? or Parameter.find_by_name('Adgang').value == "Åben"

      @search_post = Post.forside_blogs_active.search(params[:search])
      @posts = @search_post.all.paginate :page => params[:page_post], :per_page => 4

      @search_activity = Activity.forside_activities.search(params[:search])
      @activities = @search_activity.all.paginate :page => params[:page_activity], :per_page => 3

      @search_event = Event.forside_events.search(params[:search])
      @events = @search_event.all.paginate :page => params[:page_event], :per_page => 4

      #@posts = Post.forside_blogs_active.all(:limit => 4)
      @whereabouts = Parameter.find_by_name('Whereabouts').value
      @facebook = Parameter.find_by_name('Facebook').value
      @twitter = Parameter.find_by_name('Twitter').value
      @youtube = Parameter.find_by_name('Youtube').value

      render :action => "show"

    else
      
         redirect_to root_url

    end

  end

  def index
    @pagetitle = 'Overskrifter fra Viewercontroller!'
  end

  private

  def archive_count

    if Newsarchive.active.count < 3
      @archives = Newsarchive.active
    else

      if session[:archive_count].to_i >= (Newsarchive.active.count - 1) or session[:archive_count] == nil
        session[:archive_count] = 2
      else
        session[:archive_count] = session[:archive_count] + 2
      end
      @a = session[:archive_count] - 2
      @b = session[:archive_count]
      @archives = Newsarchive.active[@a..@b]
    end
  end


  def test_web_browser
    catch(:match) do
      ["Apple", "Firefox/3", "Firefox/2", "MSIE 6", "MSIE 7", "Opera"].each do |ua|
        throw(:match, ua.gsub(/[^a-z0-9]/i, "")) if request.user_agent =~ Regexp.new(ua)
      end
      nil
    end
  end

end
