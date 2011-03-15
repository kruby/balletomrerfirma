# Methods added to this helper will be available to all templates in the application.
# Du kan ikke få adgang til metoder her fra din controller, kun fra dine views
module ApplicationHelper
     
 
  def google_analytics_js
    "<script type='text/javascript'>

      var _gaq = _gaq || [];
      _gaq.push(['_setAccount', 'UA-20355035-4']);
      _gaq.push(['_trackPageview']);

      (function() {
        var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
        ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
        var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
      })();

    </script>"
  end
  
  def clippy(text, bgcolor='#FFFFFF')
    html = <<-EOF
      <object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000"
              width="30"
              height="30"
              id="clippy" >
      <param name="movie" value="/flash/clippy.swf"/>
      <param name="allowScriptAccess" value="always" />
      <param name="quality" value="high" />
      <param name="scale" value="noscale" />
      <param NAME="FlashVars" value="text=#{text}">
      <param name="bgcolor" value="#{bgcolor}">
      <embed src="/flash/clippy.swf"
             width="110"
             height="19"
             name="clippy"
             quality="high"
             allowScriptAccess="always"
             type="application/x-shockwave-flash"
             pluginspage="http://www.macromedia.com/go/getflashplayer"
             FlashVars="text=#{text}"
             bgcolor="#{bgcolor}"
      />
      </object>
    EOF
  end
  
  
  
  def image
      if @image
        if @image_class
  	      image_tag(@image, :class => @image_class)
	      else
	        image_tag(@image, :class => 'foto_lille')
	      end
	    else
	      image_tag('/images/forside.gif', :class => 'foto_lille')
  	  end
	end
	  
  # def active
  #     @aktiv_besked = "Hvis siden ikke er aktiv, kan 'hackere' ikke se den via ændring i URL"
  #   end
    
  def nice_timestamp(timestamp)
    h timestamp.strftime("%d.%m.%y - %H:%M")
  end
  
  def nice_timestamp_update(timestamp)
    h timestamp.strftime("%d.%m.%y - %H:%M:%S")
  end
    
  def nice_date(datoen)
      return datoen.strftime('%d.%m.%y')
  end
  
  def nice_time(tiden)
    return tiden.strftime(' - %H:%M')
  end
  
  def nice_date_db(datoen)
      return datoen.strftime('%y-%m-%d')
  end
  
  def nice_date_form(datoen)
      return datoen.strftime('%d-%m-%Y')
  end
  
  def wingedoff(modtaget)
    if modtaget == true
    	return '√' 
    else 
    	return '–' 
    end
  end
  
  def active_test(active)
    if active == true
  			@aktiv = '√' 
  	else 
  			@aktiv = '–' 
  	end
  end
  
  def autotab
    @current_tab ||= 0
    @current_tab += 1
  end
  
   
end
