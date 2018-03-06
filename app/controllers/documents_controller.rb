class DocumentsController < ApplicationController
  def create
    if params[:document][:file] 
      file_name = params[:document][:file_name]
      file = File.new("/home/cardolfo/temp/#{file_name}","rw")
      file.write(Base64.decode64(params[:document][:file])
    end
  end
end
