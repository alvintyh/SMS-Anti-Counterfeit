ActiveAdmin.register Dnfile, sort_order: "created_at_desc" do
  
  #belongs_to :project, finder: :find_by_url!
  #controller.resources_configuration[:self][:finder] = :find_by_url!
  
  menu false
  
  filter :description
  filter :created_at
  filter :updated_at
  
  index do
    selectable_column
    column(:file, sortable: :file) { |f| link_to File.basename(f.file.current_path), f.file.url, target: "_blank" }
    column(:description) { |f| truncate(f.description, length: 75) }
    column(:created, sortable: :created_at) do |f|
      f.created_at 
    end

    column(:updated, sortable: :updated_at) do |f|
      f.updated_at 
    end
    default_actions
  end
  
  form do |f|
    f.inputs "Attachment" do
      f.input :file
      f.input :description
    end
    f.buttons
  end
  #m = SanPham.where(:dnfile_id => :id).first
  show  do
    panel "Attachment" do
      attributes_table_for resource do
        row(:file) { link_to File.basename(resource.file.current_path), resource.file.url, target: "_blank" }
        row(:description)
        row(:created) do |f|
          f.created_at 
        end
        row(:updated) do |f|
          f.updated_at 
        end
      end
    end
  end
  
end

