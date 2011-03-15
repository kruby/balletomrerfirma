class RelationsController < ApplicationController

  before_filter :login_required, :user_required

  # GET /relations
  # GET /relations.xml
  def index    
    @search = Relation.searchlogic(params[:search])
    @relations = @search.all.paginate :page => params[:page], :per_page => 30

    session[:page] = params[:page]

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @relations }
    end
  end

  def relations_data
    #@relations = Relation.find(:all, :order => "id")

    @search = Relation.searchlogic(params[:search])
    @relations = @search.all.paginate :page => params[:page], :per_page => 30

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @relations }
    end
  end


  # GET /relations/1
  # GET /relations/1.xml
  def show
    #@relation = Relation.find(params[:id])

    redirect_to(:action => 'index', :page => session[:page])

    # respond_to do |format|
    #       format.html # show.html.erb
    #       format.xml  { render :xml => @relation }
    #     end
  end

  # GET /relations/new
  # GET /relations/new.xml
  def new
    @relation = Relation.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @relation }
    end
  end

  # GET /relations/1/edit
  def edit
    @relation = Relation.find(params[:id])
  end

  # POST /relations
  # POST /relations.xml
  def create
    @relation = Relation.new(params[:relation])

    respond_to do |format|
      if @relation.save
        flash[:notice] = 'Oprettet'
        format.html { redirect_to(@relation) }
        format.xml  { render :xml => @relation, :status => :created, :location => @relation }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @relation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /relations/1
  # PUT /relations/1.xml
  def update
    @relation = Relation.find(params[:id])

    respond_to do |format|
      if @relation.update_attributes(params[:relation])
        flash[:notice] = 'Opdateret'
        #format.html { redirect_to(@relation) }
        format.html { redirect_to(@relation) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @relation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /relations/1
  # DELETE /relations/1.xml
  def destroy
    @relation = Relation.find(params[:id])
    @relation.destroy

    respond_to do |format|
      format.html { redirect_to(relations_url) }
      format.xml  { head :ok }
    end
  end

  def email_relation_info
    @relation = Relation.find(params[:id])
    @user = current_user
    UserMailer.deliver_relation_info(@user, @relation)
    flash[:notice] = "Email blev sendt"
    redirect_to(:action => 'index')

  end

  def email_relation_info_dp
    @relation = Relation.find(params[:id])
    @user = User.find_by_email('paaske@stofanet.dk')
    UserMailer.deliver_relation_info(@user, @relation)
    flash[:notice] = "Email blev sendt til DP"
    redirect_to(:action => 'index')

  end

  def next_action

    @search = Relation.next_actions.search(params[:search])
    #@relations = @search.all.paginate :page => params[:page], :per_page => 30

    @relations = @search.all.paginate :page => params[:page], :per_page => 30

    session[:page] = params[:page]

    render (:action => 'index')
  end  


end
