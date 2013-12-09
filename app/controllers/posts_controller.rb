class PostsController < ApplicationController
  
  before_filter :login_required, :except => ['post_simple', 'show']
  before_filter :admin_required, :only => ['index', 'edit', 'create', 'update']
  
  layout 'application'
  
  # GET /posts
  # GET /posts.xml
  def index
    #@posts = Post.search(params[:search], params[:page])
    
    @search = Post.search(params[:search])
    @posts = @search.all.paginate :page => params[:page], :per_page => 30
    
    render :layout => 'application'
  end
  
  
  def show
    # session[:single_blog] = true
    @post = Post.find(params[:id])
    # if @post.parent_id? == true
    #   @post = Post.find(@post.parent_id)
    # end
    
    @stylesheet = 'kruby_blogpost'
    
    render :layout => 'viewer'
    
  end
  
  def post_simple

    @post = Post.find(params[:id])
    
    render :layout => 'viewer'
    
  end
  
  # GET /posts/new
  # GET /posts/new.xml
  def new
    session[:single_blog] = nil
    @post = Post.new
    
    render :layout => 'application'

  end
  
  def new_asset_line
    @assetable = Assetable.new

  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
    @attachments = Attachment.find_all_by_attachable_id(params[:id])
    
    render :layout => 'application'
 
  end

  # POST /posts
  # POST /posts.xml
  def create
    @post = Post.new(params[:post])

    respond_to do |format|
      if @post.save
        flash[:notice] = 'Oprettet'
        format.html { redirect_to(:action => 'blog', :page => session[:page]) }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.xml
  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        flash[:notice] = 'Opdateret'
          #format.html { redirect_to(:action => 'blog', :page => session[:page]) }
          format.html { redirect_to edit_post_path(@post) }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  
  # GET /posts
  # GET /posts.xml
  
  def blog
    #@posts = Post.search(params[:search], params[:page])
    
    @search = Post.active_posts.search(params[:search])
    @posts = @search.all.paginate :page => params[:page], :per_page => 30
    
    session[:single_blog] = nil
    session[:page] = params[:page]
    
    render(:layout => 'application')
  end
  
  def mini_blog

    #@posts = Post.find(:all, :conditions => ["parent_id IS NULL AND active = ?", true], :order => "created_at ASC")
    #@posts = Post.find(:all, :conditions => ["parent_id IS NULL", true], :order => "created_at ASC")
    
    @search = Post.active_posts.search(params[:search])
    @posts = @search.all.paginate :page => params[:page], :per_page => 30
     
    render(:layout => 'application')
     
  end 
  

  def list_comments
    session[:post_id] = params[:id]
    redirect_to(:action => 'blog', :page => session[:page])
  end
  
  
  def no_comments
    session[:post_id] = nil
    redirect_to(:action => 'blog', :page => session[:page])
  end
  
  
  def new_comment
    @post = Post.find(params[:id])
    @post_id = params[:id]
    @post_title = @post.title
    @post = Post.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @post }
    end
    
  end


  # GET /posts/1
  # GET /posts/1.xml
  
  # DELETE /posts/1
  # DELETE /posts/1.xml
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:notice] = 'Slettet'
     
      respond_to do |format|
        #format.html { redirect_to(posts_url) }
        format.html { redirect_to(:action => 'blog', :page => session[:page]) }
        format.xml  { head :ok }
      end
  end
  
  def sorter_dato
    if session[:sorter] == 11
      session[:sorter] = 10
    else
      session[:sorter] = 11
    end
    redirect_to(:action => 'mini_blog')
  end
  
  def sorter_forfatter
    if session[:sorter] == 21
      session[:sorter] = 20
    else
      session[:sorter] = 21
    end
    redirect_to(:action => 'mini_blog')
  end
  
  def sorter_kommentar
    if session[:sorter] == 31
      session[:sorter] = 30
    else
      session[:sorter] = 31
    end
    redirect_to(:action => 'mini_blog')
  end
  
  def email_new_blogpost_created
    @user = current_user
    @post = Post.find(params[:id])
    @blogmailers = User.blogmailers
    UserMailer.deliver_new_blogpost_created_ny(@user, @post, @blogmailers) #deliver_new_blogpost_created_ny henter automatisk de Users der er vinget af i blogmail.
    flash[:notice] = "Email blev sendt"
    flash[:blognames] = " (Modtagere: " + @blogmailers.collect{|u| u.blogname}.join(', ') + ") "
    redirect_to(:action => 'blog')
  end
  
  def email_new_comment_created
    @post = Post.find(params[:id])
    @parent = Post.find(@post.parent_id)
    @user = current_user
    UserMailer.deliver_new_comment_created(@user, @post, @parent)
    flash[:notice] = "Email blev sendt"
    redirect_to(:action => 'blog')

  end
  
  
end




