class DocumentsController < ApplicationController
  
  def create
    
    file_content_encoded_base64 = document_params[:file]

    if file_content_encoded_base64 
      #file_name = document_params[:file_name]   
      save(file_content_decoded_base64(file_content_encoded_base64))
    end
  end

  def file_content_decoded_base64(file_content_encoded_base64)
    Base64.decode64(file_content_encoded_base64) 
  end

  def save(file_content)
    #File.open("/home/tj.ce.gov.br/8880/Temp/#{file_name}","w:UTF-8") do |file|
    File.open("/home/cardolfo/Temp/Novo.pdf","w:UTF-8") do |file|
      file.write(file_content.force_encoding("UTF-8"))        
      file.close
    end
  end

  def document_params
    params.require(:document).permit(:file, :file_name)
  end

end
