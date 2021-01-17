User.create!(
  [
    {
      email: 'test1@example.com',
      name: 'パンチョ',
      password: 'pass123',
      password_confirmation: 'pass123'
    },
    {
      email: 'test2@example.com',
      name: 'ピンチョ',
      password: 'pass123',
      password_confirmation: 'pass123'
    },
    {
      email: 'test3@example.com',
      name: '大塩平八郎',
      password: 'pass123',
      password_confirmation: 'pass123'
    }
  ]
)

users = User.order(:created_at).take(3)
50.times do |n|
  title = "Question#{n + 1}"
  content = "Question is …#{n + 1}"
  users.each { |user| user.questions.create!(title: title, content: content) }
end
