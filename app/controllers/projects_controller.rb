class ProjectsController < ApplicationController
  
  before_filter :login_required, :editor_required, :except => ['projekter', 'show']
  
  # GET /projects
  # GET /projects.xml
  def index
    @projects = Project.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @projects }
    end
  end
  
  def projekter
    #@projects = Project.active_projects
    
    if logged_in? or site_is_open
    
      @search = Project.active_projects(params[:search])
      @projects = @search.all.paginate :page => params[:page], :per_page => 10
    
      @stylesheet = 'kruby_projectslist'

      session[:menu_id] = Page.find_by_name('Projekter').id
      render :layout => 'viewer'

    else
      
      redirect_to root_url
      
    end
    
  end

  # GET /projects/1
  # GET /projects/1.xml
  def show
    @project = Project.find(params[:id])
    
    @stylesheet = 'kruby_projectslist'

    render :layout => 'viewer'

  end

  # GET /projects/new
  # GET /projects/new.xml
  def new
    @project = Project.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @project }
    end
  end

  # GET /projects/1/edit
  def edit
    @project = Project.find(params[:id])
  end

  # POST /projects
  # POST /projects.xml
  def create
    @project = Project.new(params[:project])

    respond_to do |format|
      if @project.save
        flash[:notice] = 'Projektet blev oprettet.'
        format.html { redirect_to(edit_project_path(@project)) }
        format.xml  { render :xml => @project, :status => :created, :location => @project }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /projects/1
  # PUT /projects/1.xml
  def update
    @project = Project.find(params[:id])

    respond_to do |format|
      if @project.update_attributes(params[:project])
        flash[:notice] = 'Projektet blev opdateret.'
        format.html { redirect_to(edit_project_path) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.xml
  def destroy
    @project = Project.find(params[:id])
    @project.destroy

    respond_to do |format|
      format.html { redirect_to(projects_url) }
      format.xml  { head :ok }
    end
  end
end
