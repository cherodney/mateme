class BarcodesController < ApplicationController
  def new
  end

  def create
    @barcode = params[:barcode]
    print_and_redirect("/barcodes/label?barcode=#{@barcode}", '/admin')  
  end

  def label
    @barcode = params[:barcode]    
    label = ZebraPrinter::StandardLabel.new
    label.font_size = 2
    label.font_horizontal_multiplier = 2
    label.font_vertical_multiplier = 2
    label.left_margin = 50
    label.draw_barcode(50,180,0,1,5,15,120,false,"#{@barcode}")
    data = label.print(1)
    send_data(data,
      :type=>"application/label; charset=utf-8", 
      :stream => false, 
      :filename => "#{@barcode}#{rand(10000)}.lbl", 
      :disposition => "inline")
  end  
end