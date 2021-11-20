ActiveAdmin.register Problem do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :case_id, :label, :photo_url, :description
  #
  # or
  #
  # permit_params do
  #   permitted = [:case_id, :label, :photo_url, :description]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end


  show do |problem|
    attributes_table do
      # row :case_id, problem.id
      row :case do
        link_to problem.case.case_name, admin_case_path(problem.case)
      end
      row :label, problem.label
      row :photo_url do
        image_tag(problem.photo_url)
      end
      row :description, problem.description
      row :created_at, problem.created_at.to_s
      row :updated_at, problem.updated_at.to_s
    end
  end

end