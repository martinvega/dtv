class Contact < ActiveRecord::Base
  default_scope :order => 'date'

  # Relaciones
  belongs_to :contact_state
  belongs_to :user
  
  accepts_nested_attributes_for :contact_state
  
  # Validaciones
  validates :name, :number, :presence => true
  validates_length_of :name, :locality, :comment, :maximum => 255
  validates_numericality_of :number, :only_integer => true, :allow_nil => true,
    :allow_blank => true, :greater_than => 0, :less_than => 10000000000
  validates_uniqueness_of :number, :name, :allow_nil => true, :allow_blank => true
  validates_date :date, :allow_nil => true, :allow_blank => true
  
  def self.to_pdf(contacts)
    pdf = Prawn::Document.new(PDF_OPTIONS)
    pdf.font_size = PDF_FONT_SIZE

    # Presentación
    pdf.font_size((PDF_FONT_SIZE * 1.2).round) do
      pdf.text 'Bolsa de Contactos', :style => :bold, :align => :center

      pdf.move_down pdf.font_size
    end
    
    # Imagen 
    #image = "#{Rails.root.to_s}/public/images/logo.jpg"
    #pdf.image image, :scale => 0.2311    
    
    data = []
    state = ''
    comment = ''
    data[0] = ['Fecha', 'Nombre', 'Número', 'Estado', 'Comentario' ]
    
    contacts.each_with_index do |contact, i|
      if contact.contact_state.nil?
        state = '---'
      else
        state = contact.contact_state.state        
      end
      
      if contact.comment.present?
        comment = contact.comment
      else
        comment = '---'
      end
      
      data[i+1] = [contact.date, contact.name, contact.number, 
          state, comment]
    end

    pdf.font_size((PDF_FONT_SIZE * 0.5).round) do
      pdf.table data, :row_colors => ["FFFFFF","DDDDDD"],
        :width => pdf.margin_box.width
    end
    # Numeración en pie de página
    pdf.page_count.times do |i|
      pdf.go_to_page(i+1)
      pdf.draw_text "#{i+1} / #{pdf.page_count}", :at=>[1,1], :size => (PDF_FONT_SIZE * 0.75).round
    end
    
    FileUtils.mkdir_p File.dirname(Contact.pdf_full_path)
    pdf.render_file Contact.pdf_full_path
    
  end

  def self.pdf_name
    'bolsaContactosMultisat.pdf'
  end
  
  def self.pdf_relative_path
    File.join(*(['pdfs'] + ('%08d' % 1010).scan(/..../) + [Contact.pdf_name]))
  end

  def self.pdf_full_path
    File.join(PUBLIC_PATH, Contact.pdf_relative_path)
  end
  
end
