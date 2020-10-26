20.times do |n|
  Post.create!(
      title: "マクドナルド#{n}号店",
      rating: rand(1..5),
      description: "いいような、良くないような"

  )
end