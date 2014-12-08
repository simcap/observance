# Observance

Given a collection of observations it returns the most likely. An observation is anything
that is an Array or that responds to `to_h`.

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

The probable outcome seems to be 8-(6 or 9)-7-4. So best observation
would either be 8-6-7-4 or 8-9-7-4.

Using Observance we determine the most likely observation(s) with

```ruby
observations = Observance.run(observer_1, observer_2, observer_3,
                                observer_4, observer_5)

r1 = observations[0]
r1.rating #=> 0.55
r1.object #=> {first: 8, second: 6, third: 7, fourth: 4}

r2 = observations[1]
r2.rating #=> 0.55
r2.object #=> {:first=>8, :second=>9, :third=>7, :fourth=>4}

r3 = observations[2]
r3.rating #=> 0.5
r3.object #=> {:first=>8, :second=>6, :third=>1, :fourth=>4}

r4 = observations[3]
r4.rating #=> 0.4
r4.object #=> {:first=>8, :second=>9, :third=>2, :fourth=>8}
```

As expected it gives us that observer_2 and observer_3 are equally the most likely to have happen

## Installation

Add `gem 'observance'` to your Gemfile or run `gem install observance`

## Usage

This gem runs on given collections of observations. An observation must be an Array
or anything that responds to `to_h`.

Hashes or Arrays

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

Since a observation object is anything that responds to `to_h`, an observation
can be a Hash, a parsed JSON, or a slightly modified Struct

```ruby
# Observation as a slightly modified Struct
Scores = Struct.new(:period_1, :period_2, :period_3, period_4) do
  def to_h
    Hash[members.zip(to_a)]
  end
end

tom_observations = Scores.new(5, 6, 7, 4)
jane_observations = Scores.new(5, 5, 7, 4)

Observance.run(tom_observations, jane_observations)
```

The result returned is an ordered collection of Observance::Observed objects

```ruby
results = Observance.observed(o1, o2, o3, o4, o5)
observed_1, observed_2, _ = results

observed_1.factor = 0.7515
observed_1.object == 01

```
