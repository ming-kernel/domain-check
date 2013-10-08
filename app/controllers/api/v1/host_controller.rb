class Api::V1::HostController < ApplicationController
  respond_to :json
  def show
    err, @rsp = HostService.query(params[:id])
    if err
      render :json => {:error => err}, :status => 404
    else
      render :json => {:response => @rsp}
    end
  end
end


