class WhoisController < ApplicationController
  def show
    err, @rsp = WhoisService.query(params[:id])
    if err
      render :json => {:error => err}, :status => 422
    else
      render :json => {:response => @rsp}
    end
  end
end