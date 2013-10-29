class Api::V1::WhoisController < ApplicationController
  respond_to :json
  def show
    err, @rsp = WhoisService.query(params[:id])
    if err == nil and @rsp == nil
    	render :json => {:error => nil}, :status => 202    
    elsif err
      render :json => {:error => err}, :status => 404
    else
      render :json => {:response => @rsp}
    end
  end
end    

