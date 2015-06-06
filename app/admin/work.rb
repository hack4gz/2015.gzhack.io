ActiveAdmin.register Work do
  permit_params :team, :team_members, :title, :introduction
  index do
    selectable_column
    column :id
    column :team
    column :team_members
    column :title
    column :introduction
    column "文档附件" do |work|
      links = work.attachments.map do |attachment|
        link_to attachment.file.try(:filename), attachment.url, target: '_blank'
      end

      raw links.join('<br><br>')
    end
    column :created_at

    actions
  end

  form do |f|
    f.inputs do
      f.input :team
      f.input :team_members
      f.input :title
      f.input :introduction, :input_html => { :class => 'autogrow', :rows => 10, :cols => 20, :maxlength => 10  }
    end

    f.actions
  end
end
