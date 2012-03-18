$ ->
  $('#loading').bind
    ajaxStart: -> $(this).show()
    ajaxStop: -> $(this).hide()
    
  $(document).ready ->
    $('#datepicker').datepicker({dateFormat: 'dd-mm-yy'})
    
  $('#state_select').click ->
    if $("#state_select option:selected").text() == 'estado'
      $('.comment').fadeIn(300)
    else 
      $('.comment').fadeOut(300)
    
        
   
      
         
      
     
    
   