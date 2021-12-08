module SignInSupport
  def create_event(event)
    visit new_event_path
    fill_in 'event[event_title]', with: event.event_title
    fill_in 'event[place]', with: event.place
    select event.prefecture.name, from: 'event[prefecture_id]'
    select event.genre.name, from: 'event[genre_id]'
    select event.date.year, from: 'event[date(1i)]'
    select event.date.month, from: 'event[date(2i)]'
    select event.date.day, from: 'event[date(3i)]'
    click_on("Create")
    expect(current_path).to eq(root_path)
  end
end