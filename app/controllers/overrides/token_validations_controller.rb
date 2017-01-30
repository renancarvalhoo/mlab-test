module Overrides
  class TokenValidationsController < DeviseTokenAuth::TokenValidationsController
    def render_validate_token_success
      render json: {
        data: @resource.token_validation_response.merge({"permissions" => 'foo' })
      }
    end
  end
end
~                                                                                                                      
~                                                                                                                      
~                                                                                                                      
~                                                                                                                      
~                                                                                                                      
~          
