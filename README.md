# Observance

Given a collection of observations it returns the most likely. An observation is anything that responds to `to_a` Array or that responds to `to_h`.

As an example imagine a person flashing at a distance a card
displaying a number from 1 to 10. If five people are observing
this remote scene and note their observations during 4 rounds we have

```ruby
observer_1 = {first: 8, second: 6, third: 1, fourth: 4}
observer_2 = {first: 8, second: 6, third: 7, fourth: 4}
observer_3 = {first: 8, second: 9, third: 7, fourth: 4}
observer_4 = {first: 8, second: 9, third: 2, fourth: 8}
observer_5 = {first: 0, second: 2, third: 0, fourth: 1}
```

The probable outcome seems to be `8-(6 or 9)-7-4`. So the best observation
would either be `8-6-7-4` or `8-9-7-4`.

Using `Observance` we determine the most likely observation(s) by doing:

```ruby
observations = Observance.run(observer_1, observer_2, observer_3,
                                observer_4, observer_5)

observations[0].rating #=> 0.55
observations[0].object #=> observer_2

observations[1].rating #=> 0.55
observations[1].object #=> observer_3

observations[2].rating #=> 0.5
observations[3].rating #=> 0.4
observations[4].rating #=> 0.2
```

As expected it gives us that observer_2 and observer_3 are equally the most likely to have happened

## Installation

Add `gem 'observance'` to your Gemfile or run `gem install observance`

## Testing

This gem uses minitest. To test just run `bundle exec rake`.

## Features

* Handle observations of **different sizes** (although makes less sense)
* Observations can be **JSON documents** since Observance handles nested hashes
* Filter which set of keys to run Observance on

## Usage

### Observance input

Observance needs as input collections of observations. An observation is anything
that responds to `to_a` or `to_h`.

For instance Hashes or Arrays:

```ruby
o1 = {first_toss: 'head', second_toss: 'tail', third_toss: 'tail'}
o2 = {first_toss: 'head', second_toss: 'tail', third_toss: 'tail'}
o3 = {first_toss: 'tail', second_toss: 'tail', third_toss: 'tail'}

Observance.run(o1, o2, o3)

o1 = ['head', 'tail', 'tail']
o2 = ['head', 'tail', 'tail']
o3 = ['tail', 'tail', 'tail']

Observance.run(o1, o2, o3)

```

Since a observation object is anything that responds to `to_a` or `to_h`, it
can also be a parsed JSON, or a slightly modified Struct as follows:

```ruby
# Observation as a slightly modified Struct
Scores = Struct.new(:period_1, :period_2, :period_3, :period_4) do
  def to_h
    Hash[members.zip(to_a)]
  end
end

tom_observations = Scores.new(5, 6, 7, 4)
jane_observations = Scores.new(5, 5, 7, 4)
bill_observations = Scores.new(5, 6, 6, 4)

results = Observance.run(tom_observations, jane_observations, bill_observations)
results.first #=> Tom sample is the most likely with a rating of 0.8333
```

### Observance output

Running Observance, it returns a sorted Array of `Observance::Observation` objects. Each `Observance::Observation` contains the original observation object (usually a hash) along with a **rating** (a float number between 0 and 1).

**The higher the rating the better the observation.**

The output Array of result is sorted by rating - with the highest rating (most likely) being the first.

## Simple example

5 people observe a coin being tossed 5 times. Each sends their observations as an Array

```ruby
o1 = ['head', 'tail', 'tail', 'head', 'tail']
o2 = ['tail', 'tail', 'tail', 'head', 'tail']
o3 = ['head', 'head', 'tail', 'head', 'tail']
o4 = ['head', 'head', 'head', 'head', 'tail']
o5 = ['head', 'tail', 'tail', 'tail', 'head']

results = Observance.run(o1, o2, o3, o4, o5)
results.class # => Array

puts results
#<struct Observance::Observation object=["head", "tail", "tail", "head", "tail"], index=0, rating=0.76>
#<struct Observance::Observation object=["head", "head", "tail", "head", "tail"], index=2, rating=0.72>
#<struct Observance::Observation object=["tail", "tail", "tail", "head", "tail"], index=1, rating=0.64>
#<struct Observance::Observation object=["head", "head", "head", "head", "tail"], index=3, rating=0.6>
#<struct Observance::Observation object=["head", "tail", "tail", "tail", "head"], index=4, rating=0.52>
```
