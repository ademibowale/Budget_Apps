ActiveRecord::ConnectionAdapters::AbstractAdapter.set_callback(:checkout, :after) do
  begin_transaction(joinable: false)
end
