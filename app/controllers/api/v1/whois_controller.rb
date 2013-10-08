module Api
  module V1
    class WhoisController < ApplicationController
      respond_to :json
      def show
        err, @rsp = WhoisService.query(params[:id])
        if err
          render :json => {:error => err}, :status => 404
        else
          render :json => {:response => @rsp}
        end
      end
    end    
  end
end

