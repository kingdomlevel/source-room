require('date')
require('pry')
require_relative('../models/artist.rb')
require_relative('../models/exhibition.rb')

lorem_ipsum = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed vel nisl consequat, faucibus quam vitae, congue nibh. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Curabitur a diam ut ante aliquam consequat. Curabitur sit amet metus quis nulla lacinia porta. Aliquam erat volutpat. Donec dapibus elementum dui, id euismod diam porttitor et. Maecenas dapibus vulputate purus, nec porttitor tortor varius non. Donec at eros at libero venenatis faucibus. Maecenas id blandit augue. In gravida, tellus vel fringilla dapibus, leo magna tincidunt ante, id porta sem tellus eget velit. Sed in ligula tellus. Pellentesque est arcu, venenatis id ante sit amet, finibus viverra orci.

Duis varius tincidunt ligula nec convallis. Morbi non interdum risus, ac dignissim arcu. Morbi vel euismod lorem. Morbi eu ultricies nisi. Duis vulputate lorem non interdum consectetur. Nunc sagittis sem lectus, et tempus risus venenatis at. Nullam sed dignissim tortor. Donec vitae augue quis quam blandit iaculis. Nullam imperdiet egestas ipsum. Nunc non metus interdum, auctor nisl viverra, molestie augue. Nulla finibus quis arcu suscipit vulputate. In vel tortor quis nibh vehicula ultricies nec non risus.'

niall = Artist.new({
    'name' => 'Niall Morris',
    'year_born' => 1991,
    'hometown' => 'Glasgow'
})
niall.save()

delilah = Artist.new({
    'name' => 'Delilah Lozano',
    'year_born' => 1984,
    'hometown' => 'New York City'
})
delilah.save()

suzanne = Artist.new({
    'name' => 'Suzanne Haraway',
    'year_born' => 1995,
    'hometown' => 'Belfast'
})
suzanne.save()

warren = Artist.new({
    'name' => 'Warren Treister',
    'year_born' => 1958,
    'hometown' => 'London'
})
warren.save()

windfarm_exhibit = Exhibition.new({
    'title' => 'ambulance blues',
    'description' => lorem_ipsum,
    'start_date' => Date.new(2019, 8, 30),
    'end_date' => Date.new(2019, 10, 4),
    'artists' => [niall]
})
windfarm_exhibit.save()

lookout_exhibit = Exhibition.new({
    'title' =>  'Lookout',
    'description' => lorem_ipsum,
    'start_date' => Date.new(2019, 8, 9),
    'end_date' => Date.new(2019, 9, 30),
    'artists' => [delilah, warren]
})
lookout_exhibit.save()

gardener_exhibit = Exhibition.new({
    'title' =>  'The Gardener',
    'description' => lorem_ipsum,
    'start_date' => Date.new(2019, 9, 24),
    'end_date' => Date.new(2019, 11, 11),
    'artists' => [suzanne]
})
gardener_exhibit.save()

better_rainfall_exhibit = Exhibition.new({
    'title' =>  'Better Rainfall',
    'description' => lorem_ipsum,
    'start_date' => Date.new(2019, 7, 1),
    'end_date' => Date.new(2019, 8, 14),
    'artists' => [delilah]
})
better_rainfall_exhibit.save()

