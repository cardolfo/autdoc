class DocumentsController < ApplicationController
  def create
    if params[:document][:file] 
      file_name = params[:document][:file_name]
      content_file_str = Base64.decode64(params[:document][:file])           
      File.open("/home/tj.ce.gov.br/8880/Temp/#{file_name}","w:UTF-8") do |file|
        file.write(content_file_str.force_encoding("UTF-8"))        
        file.close
      end      
    end
  end
end
