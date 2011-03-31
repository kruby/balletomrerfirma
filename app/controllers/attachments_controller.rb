class AttachmentsController < ApplicationController
  # GET /attachments
  # GET /attachments.xml
  
  before_filter :login_required, :editor_required
  # Hvert attachment hører til en post, post hører til et team_id (subdomæne).
  # Her bruger jeg :load_team for at få fat i de rigtige assets, og udnytter at de har et team_id.
  
  def index
    #raise params.to_yaml

    #Denne bruges, så man f.eks kan sige: posts/10/attachments i sin URL. Det vil ellers ikke virke selvom polymorphic er på plads.
    @attachable = find_attachable

    #Brugte en if her, da jeg ellers ikke kunne finde alle attachments, uden at have specificeret f.eks. en post
    if @attachable.blank?
      #@attachments = Attachment.search(params[:search], params[:page])
      #Hvis der ikke er lagt fotos op i assets går den hertil.
      
      redirect_to :action => 'index_normal'        
    else
      #@page == params[:page]   
      @attachments = @attachable.attachments.paginate(:page => params[:page])
      #@assets = Asset.search(params[:search], params[:page])
      @assets = Asset.descend_by_id.all.paginate :page => params[:page], :per_page => 30

    end

  end

  def index_normal
    #raise params.to_yaml
    @search = Attachment.search(params[:search])
    @attachments = @search.all.paginate :page => params[:page], :per_page => 30
    
  
    #@attachments = Attachment.search(params[:search], params[:page])
    #@attachments = Attachment.find(:all)

  end

  # GET /attachments/1
  # GET /attachments/1.xml
  def show
    @attachment = Attachment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @attachment }
    end
  end

  # GET /attachments/new
  # GET /attachments/new.xml
  def new
    #raise params.to_yaml
    @attachment = Attachment.new
        
            respond_to do |format|
              format.html # new.html.erb
              format.xml  { render :xml => @attachment }
            end
  end

  # GET /attachments/1/edit
  def edit
    @attachment = Attachment.find(params[:id])
  end

  # POST /attachments
  # POST /attachments.xml
  def create
    @asset_id = params[:id]
    @attachable = find_attachable #Vi finder ud af hvilken type attachable er og finder den attachable der skal oprettes attachments til.
    
    @array = attachment_ids(@attachable)
      
          if @array.include?(params[:id].to_i)
            if params[:product_id]
              render product_attachments_path(:product_id => @attachable.id)
            else
              render post_attachments_path(:post_id => @attachable.id)
            end
          
          else
            #raise params.to_yaml
            @attachment = @attachable.attachments.build(:asset_id => @asset_id)
            @attachment.description = Asset.find(@asset_id).description
            @attachment.save!
            if params[:product_id]
              redirect_to product_attachments_path(:product_id => @attachable.id)
            else
              redirect_to post_attachments_path(:post_id => @attachable.id)
            end
            
          end
  
  end


  def edit_multiple
    #raise params.to_yaml
    @asset_ids = params[:asset_ids]
    @post = Post.find(params[:post_id])

    if @asset_ids
      @assets = Asset.find(@asset_ids)
      @assets.each do |asset|
        @post.attachments.build(:attachable_id => @post.id, :asset_id => asset.id, :attachable_type => 'Post')
      end

      @post.save!
      redirect_to edit_post_path(@post)
    else
      redirect_to add_to_post_path(@post)
      flash[:notice] = 'You must add photos or go back'

    end  
  end

  # PUT /attachments/1
  # PUT /attachments/1.xml
  def update
    @attachment = Attachment.find(params[:id])

    respond_to do |format|
      if @attachment.update_attributes(params[:attachment])
        flash[:notice] = 'Opdateret'
        #format.html { redirect_to(@attachment) }
        format.html { render :action => "edit" }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @attachment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /attachments/1
  # DELETE /attachments/1.xml
  def destroy
    @attachment = Attachment.find(params[:id])
    @attachment.destroy
    
    #redirect_to :action => 'index_normal'
    if @attachment.attachable_type == 'Product'
      redirect_to edit_product_path(@attachment.attachable_id)
    else
      redirect_to edit_post_path(@attachment.attachable_id)
    end
    # respond_to do |format|
    #   format.html { redirect_to(attachments_url) }
    #   format.xml  { head :ok }
    # end
  end

  # def destroy_from_post
  #    @attachment = Attachment.find(params[:id])
  #    @post_id = @attachment.attachable_id
  #    @attachment.destroy
  # 
  #    #redirect_to (:controller => 'post', :id => params[:post_id], :action => 'edit' )
  #    redirect_to edit_post_path(@post_id)
  #  end
   
  
  def prioritize_attachments
    if params[:project_id]
      project = Project.find(params[:project_id])
      attachments = project.attachments
    else
      post = Post.find(params[:post_id])
      attachments = post.attachments
    end
      attachments.each do |attachment|
      attachment.position = params['attachment'].index(attachment.id.to_s) + 1
      attachment.save

    end
    render :nothing => true
  end
  
  # def sort_attachments_positions
  #   #raise params.to_yaml
  #   @attachable = find_attachable
  #   
  #   params[:attachment].each_with_index do |id, index|
  #     @attachable.attachments.update_all(['position=?', index+1], ['id=?', id])
  #   end
  #   render :nothing => true
  # end


  private

  def find_attachable
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
    nil
  end

  def attachment_ids(attachable)
    #raise params.to_yaml
    #@attachment_ids = Attachment.find_all_by_attachable_id(attachable.id, :select => :asset_id)
    
    #NEDENFOR GØR VI FORSKEL PÅ OM DER SKAL FINDES ATTACHMENTS TIL POST ELLER PRODUCT
    if params[:post_id]
      @attachment_ids = Post.find(attachable.id).attachments(:select => :asset_id)
    else
      @attachment_ids = Project.find(attachable.id).attachments(:select => :asset_id)
    end
    @array = []
    @c = 0
    @attachment_ids.each do
      @array << @attachment_ids[@c][:asset_id]
      @c += 1
    end
    return @array
  end



end