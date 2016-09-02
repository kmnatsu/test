require 'application/exceptions/exception'

# APIの共通仕様
class Api::Base < ApplicationController
    respond_to :json
    
    rescue_from Exception do |ex|
        logger.debug(ex.backtrace.join("\n"))
        logger.error(ex.message)
        
        status = 500
        error_code = 'UNKNOWN'
        
        if ex.kind_of?(Application::Exceptions::CommonError)
            status = ex.status
            error_code = ex.error_code
        end
        
        error_response = {
            error_code: error_code,
        }
        
        render json: error_response, status: status
    end
end