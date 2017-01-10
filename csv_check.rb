require 'csv'


  def normalize(row)
    row[2].sub!(/^0+/, "") if row[2]
    row[3].sub!(/^0+/, "") if row[3]

    return row
  end

  quote_data = CSV.read("quote_data.csv")
  invoice_data = CSV.read("invoice_data.csv")

  quote_data.each { |row| normalize(row) }
  invoice_data.each { |row| normalize(row) }

  additions = invoice_data - quote_data
  deletions = quote_data - invoice_data

  puts "Additions (#{additions.size})"

  additions.each { |a| puts a.inspect }

  CSV.open("additions.csv", "w") do |csv|
    additions.each { |a| csv << a }
  end

  puts

  puts "Deletions (#{deletions.size})"

  deletions.each { |d| puts d.inspect }

  CSV.open("deletions.csv", "w") do |csv|
    deletions.each { |d| csv << d }
  end
