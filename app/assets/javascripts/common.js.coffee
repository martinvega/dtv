$ ->
  $('#loading').bind
    ajaxStart: -> $(this).show()
    ajaxStop: -> $(this).hide()
    
  $(document).ready ->
    $('#datepicker').datepicker({dateFormat: 'dd-mm-yy'})
    
  $('#state_select').click ->
    if (($("#state_select option:selected").text() == 'RE LLAMAR') || ($("#state_select option:selected").text() == 'RETENIDO') || ($("#state_select option:selected").text() == 'RETENIDO X CICLO') || ($("#state_select option:selected").text() == 'RENOVACIÓN'))
      $('.comment').fadeIn(300)
    else 
      $('.comment').fadeOut(300)
      
  $('#login input[type="submit"]').click ->
    window.open('http://www.directv.com.ar/')
    window.focus().delay(100)
    
    
        
   
      
         
      
     
    
   