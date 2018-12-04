class Record
  def self.fill_in_guard(records)
    updated_records = []
    current_guard = records.first.split(" ")[3]

    records.each do |record|
      pieces = record.split(" ")

      if pieces[2] == "Guard"
        current_guard = pieces[3]
      else
        new_record = pieces.insert(2, current_guard).join(" ")
        updated_records << new_record
      end
    end

    updated_records
  end
end
