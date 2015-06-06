ActiveAdmin.register Work do
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
end
