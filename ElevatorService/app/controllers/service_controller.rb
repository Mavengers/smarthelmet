class ServiceController < ApplicationController
    skip_before_action :verify_authenticity_token

    #
    # Create a case, with engineer_id, case_name, elevator_tag, description, post only
    def create_case
        engineer_id = params[:engineer_id]
        case_name = params[:case_name]
        elevator_tag = params[:elevator_tag]
        description = params[:description]

        begin
            new_case = Case.new(
                :engineer_id => engineer_id,
                :case_name => case_name,
                :elevator_tag => elevator_tag,
                :description => description
            )

            if !new_case.save
                render json: { :res => RES_SYS_ERR, :msg => new_case.errors }
            else
                render json: { :res => RES_SUCCESS, :case_id => new_case.id }
            end
        
            return
        rescue => e
            logger.error(e)
            logger.error(e.backtrace.join("\r"))
    
            render json: { :res => RES_SYS_ERR, :msg => e.message } # TODO: I18n
            return
        end
    end

    #
    # Create a prpblem, with case_name, label, photo, description, post only
    def create_problem
        case_name = params[:case_name]
        label = params[:label]
        photo = params[:photo]
        description = params[:description]

        begin
            problem_case = Case.where(["case_name=?", case_name]).first

            if problem_case.nil?
                render json: { :res => RES_SYS_ERR, :msg => "Case for '#{case_name}' is not found" } # TODO: I18n
                return
            end

            Rails.logger.debug problem_case.to_json

            photo_dir = "#{Rails.root}/public/photos/case_#{problem_case.id}"
            FileUtils.mkdir_p photo_dir
            
            photo_url = "/photos/case_#{problem_case.id}/#{Time.now.to_i}_#{photo.original_filename}"
            Rails.logger.debug photo_url

            file_name = "#{Rails.root}/public#{photo_url}"            
            Rails.logger.debug file_name

            file = File.open(file_name, "wb+") do |f|

                f.write(photo.read)
            end
            
            # if file.nil?
            #     # 失败的操作
            #     render json: { :res => RES_SYS_ERR, :msg => e.message } # TODO: I18n
            #     return
            # end

            new_problem = Problem.new(
                :case_id => problem_case.id,
                :label => label,
                :photo_url => photo_url,
                :description => description
            )

            new_problem.save!

            render json: { :res => RES_SUCCESS, :problem_id => new_problem.id }
            return
        rescue => e
            logger.error(e)
            logger.error(e.backtrace.join("\r"))
    
            render json: { :res => RES_SYS_ERR, :msg => e.message } # TODO: I18n
            return
        end
    end
end