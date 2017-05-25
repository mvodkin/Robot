<h1>Robot by Max Vodkin</h1>

<h3>To run:</h3>

* Make sure ruby is installed on your local machine.
* Clone this repo.
* Navigate to the robot directory and run the `script.rb`, passing commands as arguments from the console:
   ```sh
  $ ruby script.rb PLACE 0,0,NORTH MOVE REPORT
   ```

  This will print `0,1,NORTH` to the console.


<h3>Testing</h3>

To test run:

```sh
$ bundle install
$ bundle exec rspec
```
