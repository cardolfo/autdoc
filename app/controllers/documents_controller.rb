class DocumentsController < ApplicationController

  
  def path
    "/home/tj.ce.gov.br/8880/Temp"
  end

  def new_file
    "#{path}/new.pdf"
  end

  def footer_file
    "#{path}/footer.pdf"
  end

  def new_file_with_footer
    "#{path}/new_with_footer.pdf"
  end
  
  def create
    
    file_content_encoded_base64 = document_params[:file]

    if file_content_encoded_base64 
      #file_name = document_params[:file_name]   
      file_content_decoded_base64 = Base64.decode64(file_content_encoded_base64)
      file = save(file_content_decoded_base64)
      edit      
    end
  end

  def save(file_content)    
    File.open(new_file,"w:UTF-8") do |file|
      file.write(file_content.force_encoding("UTF-8"))              
    end
  end

  def edit
    create_footer
    merge_with_footer
  end

  def create_footer
    Prawn::Document.generate(footer_file) do
      string = "Para consultar a autenticidade do documento acesse http://autdoc.tjce.jus.br/5jkljfds"
      options = {
                  :at => [bounds.right - 575, 0],
                  :width => 600,
                  :align => :center,
                  :page_filter => (1..7),
                  :start_count_at => 1,
                  :color => "007700"
                }     
      number_pages string, options
    end
  end

  def merge_with_footer
    footer = CombinePDF.load(footer_file).pages[0]
    pdf = CombinePDF.load new_file
    pdf.pages.each {|page| page << footer}
    pdf.save new_file_with_footer
  end

  def document_params
    params.require(:document).permit(:file, :file_name)
  end

end
