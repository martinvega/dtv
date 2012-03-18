module ApplicationHelper
  
  def link_to_back
    link_to_function "Volver", 'history.back()', :class => :real
  end
  
  def calendar_text_field(form, attribute, time = false, value = nil)
    value ||= form.object.send(attribute)
    options = {:class => :calendar}
    
    options[:value] = l(value, :format => time ? :minimal : :default) if value
    options[:'data-time'] = true if time
    
    form.text_field attribute, options
  end
  
  # Devuelve el HTML de un campo lock_version oculto dentro de un div oculto
  #
  # * _form_:: Formulario que se utilizará para generar el campo oculto
  def hidden_lock_version(form)
    content_tag :div, form.hidden_field(:lock_version),
      :style => 'display: none;'
  end

end
