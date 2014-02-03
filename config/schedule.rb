
set :output, {:error => 'log/error.log', :standard => 'log/cron.log'}

every 1.day, :at => '4:30 am' do
  runner "Tasks::GetEntrys.execute"
end

every 1.day, :at => '4:30 pm' do
  runner "Tasks::GetEntrys.execute"
end

