class UserMailer < ActionMailer::Base
  
  def relation_info(user, relation)
    setup_email_1 user
    @subject    += "kundeinfo " + relation.company 
    body        :relation => relation, :user => user
  end
  
  def new_blogpost_created(user, post)
    setup_email_2 user
    @subject    += post.title 
    body        :post => post, :user => user
  end
  
  def new_blogpost_created_ny(user, post, blogmailers)
    #@blogmailers = User.blogmailers
    #@user_emails = User.connection.select_values('select email from users') #Henter alle emails fra User og opretter dem i en array med det samme
    @recipients = blogmailers.collect{|u| u.email}.join(', ') #Hver email samles fra array med et komma og mellemrum imellem.
    setup_email_2_ny(user, @recipients)
    @subject    += post.title 
    body        :post => post, :user => user
  end
  
  def new_comment_created(user, post, parent)
    setup_email_3 user
    @subject    += post.title
    body        :post => post, :user => user, :parent => parent
  end

  protected
    
    def setup_email_1(user)
      @recipients           = "#{user.email}"
      #@recipients           = "ts@kruby.dk"
      @from                 = "tina@sundmedkost.dk"
      @subject              = "SundMedKost "
      @headers["Reply-to"]  = "tina@sundmedkost.dk"
      @sent_on              = Time.now
      content_type  "text/html"
    end
    
    def setup_email_2(user)
      @recipients           = "tina@sundmedkost.dk"
      @from                 = "#{user.email}"
      @subject              = "Nyt fra bloggen: "
      @headers["Reply-to"]  = "#{user.email}"
      @sent_on              = Time.now
      content_type  "text/html"
    end
    
    def setup_email_2_ny(user, recipients)
      @recipients           = "#{recipients}"
      @from                 = "#{user.email}"
      @subject              = "Nyt fra bloggen: "
      @headers["Reply-to"]  = "#{user.email}"
      @sent_on              = Time.now
      content_type  "text/html"
    end
    
    def setup_email_3(user)
      @recipients           = "tina@sundmedkost.dk"
      @from                 = "#{user.email}"
      @subject              = "Kommentar fra bloggen: "
      @headers["Reply-to"]  = "#{user.email}"
      @sent_on              = Time.now
      content_type  "text/html"
    end

end
