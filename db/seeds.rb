# db/seeds.rb
puts "Seeding…"

dealer_names = ["Demo Motors", "Prairie Auto Group", "Circle Drive Cars"]
dealers = dealer_names.map { |n| Dealer.find_or_create_by!(name: n) }

# users (per first dealer for demo)
d = dealers.first
users_seed = [
  { email: "gm@demo.test",      name: "Alex GM",      role: "manager" },
  { email: "manager@demo.test", name: "Casey Manager",role: "manager" },
  { email: "service@demo.test", name: "Sam Service",  role: "staff" },
  { email: "photos@demo.test",  name: "Pat Photo",    role: "staff" }
]
users_seed.each { |attrs| d.users.where(email: attrs[:email]).first_or_create!(attrs) }

# vehicles
STATUSES      = %w[draft live sold wholesale archived]
RECON_STATES  = %w[intake inspect parts service detail photo live hold]
SOURCES       = %w[trade_in auction wholesale consignment other]
DRIVETRAINS   = %w[FWD RWD AWD 4WD]
TRANSMISSIONS = %w[AT MT CVT DCT]
FUELS         = %w[gas diesel hybrid phev ev]

def rand_year = rand(2014..2023)
def random_vin
  (0...17).map { (("A".."Z").to_a + ("0".."9").to_a - %w[I O Q]).sample }.join
end

makes = {
  "Toyota" => %w[Corolla Camry RAV4], "Honda" => %w[Civic Accord CR-V],
  "Subaru" => %w[Impreza Forester Outback], "Ford" => %w[Escape F-150]
}

def pick_trim(model)
  { "Outback"=>%w[Convenience Touring Limited], "F-150"=>%w[XL XLT Lariat] }[model]&.sample || %w[Base Sport Limited].sample
end

24.times do
  mk = makes.keys.sample
  md = makes[mk].sample
  dealers.sample.vehicles.create!(
    year: rand_year, make: mk, model: md, trim: pick_trim(md),
    vin: random_vin, stock_no: "STK#{rand(10000..99999)}",
    status: STATUSES.sample, recon_state: RECON_STATES.sample, source: SOURCES.sample,
    drivetrain: DRIVETRAINS.sample, transmission: TRANSMISSIONS.sample, fuel: FUELS.sample,
    engine: ["2.5L I4","3.5L V6","1.5L Turbo","Electric"].sample, cylinders: [3,4,4,6].sample
  )
end

puts "Dealers: #{Dealer.count}, Users: #{User.count}, Vehicles: #{Vehicle.count}"
