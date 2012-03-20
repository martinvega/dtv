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