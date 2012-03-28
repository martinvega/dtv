require 'prawn/measurement_extensions'

# Meses
MONTHS = [
  'Enero',
  'Febrero',
  'Marzo',
  'Abril',
  'Mayo',
  'Junio',
  'Julio',
  'Agosto',
  'Setiembre',
  'Octubre',
  'Noviembre',
  'Diciembre'
]

# Años
YEARS = [
  2010,
  2011,
  2012
]

# Ruta a la carpeta pública
PUBLIC_PATH = File.join(Rails.root, 'public')

# Opciones por defecto para los PDFs
PDF_OPTIONS = {
  :page_size => 'A4',
  :page_layout => :portrait,
  # Margen T, R, B, L
  :margin => [20.mm, 15.mm, 20.mm, 20.mm]
}
# Tamaño de fuente normal en los PDFs
PDF_FONT_SIZE = 11

# Opciones de DIRECTV
DIRECTV_OPTIONS = [
  'DIRECTV Pregago',
  'DIRECTV Plus',
  'DIRECTV HD',
  'DIRECTV Oro',
  'DIRECTV Net'  
]

# Host
URL_HOST = (
  Rails.env.development? ? 'localhost:3000' : 'multisatdigital.com.ar'
).freeze